module CodeHunter
  class Runner
    attr_reader :options

    def self.run(*args)
      new(*args).run
    end

    def initialize(argv = [])
      @options = OptionParser.parse!(argv)
    end

    def run
      warnings = collect_warnings
      warnings = merge_git_metadata(warnings)
      p warnings
    end

    def collect_warnings
      services.map(&:run).compact.inject([], :+)
    end

    def merge_git_metadata(warnings)
      warnings.map do |warning|
        metadata = GitBlamer.new(warning).blame or next
        warning.merge(metadata)
      end.compact
    end

    private

    def services
      [Brakeman, RailsBestPractices].map {|klass| klass.new(options) }
    end

    def run_with_application_path
      Dir.chdir(application_path) { run_without_application_path }
    end
    alias_method_chain :run, :application_path

    def application_path
      options[:application_path] || "./"
    end
  end
end
