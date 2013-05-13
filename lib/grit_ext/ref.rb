module Grit
  class Ref
    def utf8_name
      GritExt.encode! name
    end
  end
end
