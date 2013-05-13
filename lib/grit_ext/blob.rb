module Grit
  class Blob

    def utf8_name
      GritExt.encode! name
    end

    def utf8_data
      GritExt.encode! data
    end

    class << self

      def utf8_blame(repo, commit, file)
        blame(repo, commit, file).map do |b,lines|
          [b, GritExt.encode!(lines.join('\n')).split('\n')]
        end
      end
    end

  end
end
