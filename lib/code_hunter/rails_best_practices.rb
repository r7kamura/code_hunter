require "code_hunter/rails_best_practices/invoker"
require "code_hunter/rails_best_practices/summarizer"
require "pathname"
require "tmpdir"

module CodeHunter
  class RailsBestPractices
    TEMPORAL_PATHNAME = Pathname.new("#{Dir.tmpdir}/rails_best_practices.html")

    attr_reader :options

    delegate :invoke, :to => :invoker
    delegate :summarize, :to => :summarizer

    def initialize(options = {})
      @options = options
    end

    def run
      invoke
      summarize
    ensure
      clean
    end

    private

    def clean
      TEMPORAL_PATHNAME.delete
    end

    def summarizer
      Summarizer.new(options)
    end

    def invoker
      Invoker.new(options)
    end
  end
end
