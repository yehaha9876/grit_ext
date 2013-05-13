module Grit
  class Tree

    def utf8_name
      GritExt.encode! name
    end
  end
end
