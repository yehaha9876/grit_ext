module Grit
  class Tag
    def utf8_message
      GritExt.encode! message
    end
    
    # fix bug for GPG key tag and tag on tag
    # at this case, the tag object is a blog, not commit
    # do not support this type of tag so far
    def self.find_all(repo, options = {})

      refs = repo.git.refs(options, prefix)
      refs.split("\n").map do |ref|
        name, id = *ref.split(' ')
        sha = repo.git.commit_from_sha(id)
        objtype = repo.git.file_type(sha)
        while objtype == 'tag'
          sha = repo.git.commit_from_sha(sha)
          objtype = repo.git.file_type(sha)
        end

        raise "Unknown object type." if sha == ''
        
        if objtype == 'commit'
          commit = Commit.create(repo, :id => sha)
        else
          commit = nil
        end

        new(name, commit)
      end
    end

    # fix bug for GPG key tag
    # at this case, the tag object is a blog, not commit
    # do not support this type of tag so far
    def lazy_source

      unless commit
        @message  = 'unsupport tag type'
        @tagger   = 'unsupport tag type'
        @tag_date = 'unsupport tag type'
        return self
      end

      data         = commit.repo.git.cat_ref({:p => true}, name)
      @message     = commit.short_message
      @tagger      = commit.author
      @tag_date    = commit.authored_date
      return self if data.empty?

      if parsed = self.class.parse_tag_data(data)
        @message  = parsed[:message]
        @tagger   = parsed[:tagger]
        @tag_date = parsed[:tag_date]
      end
      self
    end
  end
end
