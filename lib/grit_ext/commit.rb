module Grit
  class Commit

    def utf8_message
      GritExt.encode! message
    end

    def utf8_short_message
      GritExt.encode! short_message
    end
  end
end
