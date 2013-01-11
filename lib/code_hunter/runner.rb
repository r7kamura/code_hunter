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
      summary = [
        Brakeman.new(options).run,
        RailsBestPractices.new(options).run,
      ].compact.inject([], :+)

      p summary
    end
  end
end
