module CodeHunter
  class Warning
    def initialize(attributes)
      @attributes = attributes
    end

    def to_hash
      {
        :line        => line,
        :message     => message,
        :path        => path,
        :service     => service,
        :url         => url,
        :sha1        => sha1,
        :author      => author,
        :email       => email,
        :modified_at => modified_at,
      }
    end

    def line
      @attributes[:line]
    end

    def message
      @attributes[:message]
    end

    def path
      @attributes[:path]
    end

    def service
      @attributes[:service]
    end

    def url
      @attributes[:url]
    end

    def sha1
      @git_metadata[:sha1]
    end

    def author
      @git_metadata[:author]
    end

    def email
      @git_metadata[:email]
    end

    def modified_at
      @git_metadata[:modified_at]
    end

    # Fetch @git_metadata only once.
    def git_metadata
      case @git_metadata
      when nil
        @git_metadata = GitBlamer.new(@attributes).blame || false
      when false
        nil
      else
        @git_metadata
      end
    end

    def has_git_metadata?
      !!git_metadata
    end

    def ignore?
      path && line && has_ignore_annotation?
    end

    private

    def has_ignore_annotation?
      line_content =~ /#\s*ignore/i
    end

    def line_content
      File.readlines(path)[line - 1]
    end
  end
end
