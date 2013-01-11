module CodeHunter
  class GitBlamer
    def initialize(args)
      @path = args[:path]
      @line = args[:line]
    end

    def blame
      parse(invoke)
    end

    def parse(str)
      {
        :sha1        => str.lines.to_a[0][/^[0-9a-f]+/],
        :author      => str[/author (.+)/, 1],
        :email       => str[/author-mail <(.+)>/, 1],
        :modified_at => str[/author-time (\d+)/, 1],
      }
    end

    def invoke
      `git blame #@path -L #@line,+1 -l -e -p`
    end
  end
end
