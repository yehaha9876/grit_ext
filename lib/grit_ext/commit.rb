module Grit
  class Commit

    def utf8_message
      GritExt.encode! message
    end

    def utf8_short_message
      GritExt.encode! short_message
    end

    # Parse out commit information into an array of baked Commit objects
    #   +repo+ is the Repo
    #   +text+ is the text output from the git command (raw format)
    #
    # Returns Grit::Commit[] (baked)
    #
    # really should re-write this to be more accepting of non-standard commit messages
    # - it broke when 'encoding' was introduced - not sure what else might show up
    #
    # modify to skip the mergeobj for signed tags
    #
    def self.list_from_string(repo, text)
      lines = text.split("\n")

      commits = []

      while !lines.empty?
      	lines.shift while lines.first !~ /^commit/ # commit start
        id = lines.shift.split.last 
        tree = lines.shift.split.last

        parents = []
        parents << lines.shift.split.last while lines.first =~ /^parent/ 

        author_line = lines.shift
        author_line << lines.shift if lines[0] !~ /^committer/
        author, authored_date = self.actor(author_line)

        committer_line = lines.shift
        committer_line << lines.shift if lines[0] && lines[0] != '' && lines[0] !~ /^encoding/ && lines[0] != /^mergetag/
        committer, committed_date = self.actor(committer_line)

        # not doing anything with this yet, but it's sometimes there
        encoding = lines.shift.split.last if lines.first =~ /^encoding/

        # not doing anything with this yet, but it's sometimes there
        mergetag = []
        mergetag << lines.shift.split.last if lines.first =~ /^mergetag/
        mergetag << lines.shift while lines.first =~/^ /

        lines.shift

        message_lines = []
        message_lines << lines.shift[4..-1] while lines.first =~ /^ {4}/

        lines.shift while lines.first && lines.first.empty?

        commits << Commit.new(repo, id, parents, tree, author, authored_date, committer, committed_date, message_lines)
      end

      commits
    end
  end
end
