module CodeHunter
  class GitBlamer
    def initialize(args)
      @path = args[:path]
      @line = args[:line]
    end

    def blame
      result = invoke
      parse(result) unless result.empty?
    end

    def parse(str)
      {
        :sha1        => str.lines.to_a[0][/^[0-9a-f]+/],
        :author      => str[/author (.+)/, 1],
        :email       => str[/author-mail <(.+)>/, 1],
        :modified_at => str[/author-time (\d+)/, 1].to_i,
      }
    end

    def invoke
      `git blame #{File.realpath(@path)} -L #@line,+1 -l -p`
    end
  end
end
