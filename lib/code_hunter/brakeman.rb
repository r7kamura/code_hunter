require "code_hunter/brakeman/invoker"
require "code_hunter/brakeman/summarizer"
require "pathname"
require "tmpdir"

module CodeHunter
  class Brakeman
    TEMPORAL_PATHNAME = Pathname.new("#{Dir.tmpdir}/brakeman.html")

    attr_reader :options

    delegate :invoke, :to => :invoker
    delegate :summarize, :to => :summarizer

    def initialize(options = {})
      @options = options
    end

    def clean
      TEMPORAL_PATHNAME.delete
    end

    private

    def summarizer
      Summarizer.new(options)
    end

    def invoker
      Invoker.new(options)
    end
  end
end
