module Grit
  class Actor

    def uf8_name
      GritExt.encode! name
    end

    def urf8_email
      GritExt.encode! email
    end
  end
end
