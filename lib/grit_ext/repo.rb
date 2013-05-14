module Grit
  class Repo

  	# This version of diff use ruby_git instead native to show the diff. does not suppot
  	# +paths+
    # The diff from commit +a+ to commit +b+, optionally restricted to the given file(s)
    #   +a+ is the base commit
    #   +b+ is the other commit
    #   +paths+ is an optional list of file paths on which to restrict the diff
    def diff(a, b, *paths)
      diff = self.git.diff({}, a, b)
      if diff =~ /diff --git a/
        diff = diff.sub(/.*?(diff --git a)/m, '\1')
      else
        diff = ''
      end
      Diff.list_from_string(self, diff)
    end
  end
end
