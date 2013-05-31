module Grit
  class Diff

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
        if body.encoding == path.encoding
          @diff = path + body
        else
          @diff = path + ""
        end
      end
    end

    class << self
      alias_method :old_list_from_string, :list_from_string
      # fix utf-8 format error
      def self.list_from_string(repo, text)
        return self.old_list_from_string(repo, text)
      end
    end

  end
end
