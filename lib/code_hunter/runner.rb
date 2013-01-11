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
      p collect_brakeman_summary
    end

    def collect_brakeman_summary
      brakeman = Brakeman.new(options)
      brakeman.invoke
      brakeman.summarize
    ensure
      brakeman.clean
    end
  end
end
