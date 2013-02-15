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
      output   = Renderer.render(warnings, :format => options[:format])
      puts output
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
      array = []
      array << Pendaxes           if options[:pendaxes]             != false
      array << RailsBestPractices if options[:rails_best_practices] != false
      array << Brakeman           if options[:brakeman]             != false
      array.map {|klass| klass.new(options) }
    end

    def run_with_application_path
      Dir.chdir(options[:application_path]) { run_without_application_path }
    end
    alias_method_chain :run, :application_path
  end
end
