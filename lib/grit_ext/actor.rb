module Grit
  class Actor

    def utf8_name
      GritExt.encode! name
    end

    def utf8_email
      GritExt.encode! email
    end
  end
end
