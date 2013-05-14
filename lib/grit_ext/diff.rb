module Grit
  class Diff

    alias list_from_string: :old_list_from_string

    def old_path
      GritExt.encode! @a_path
    end

    def new_path
      GritExt.encode! @b_path
    end

    def utf8_diff
      if @diff.nil?
        @diff = ""
      else
        lines = @diff.lines.to_a
        path = GritExt.encode! lines.shift(2).join
        body = GritExt.encode! lines.join
        @diff = path + body
      end
    end

    # fix utf-8 format error
    def self.list_from_string(repo, text)
      return old_list_from_string(repo, text)
    end

  end
end
