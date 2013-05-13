module Grit
  class Tag
    def utf8_message
      GritExt.encode! message
    end
  end
end
