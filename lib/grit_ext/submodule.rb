module Grit
  class Submodule
    def utf8_name
      GritExt.encode! name
    end
  end
end
