module CodeHunter
  class RailsBestPractices
    class Invoker
      extend MethodLogger

      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def invoke
        system(
          "rails_best_practices",
          "--format", "html",
          "--output-file", RailsBestPractices::TEMPORAL_PATHNAME.to_s,
          :out => IO::NULL,
          :err => IO::NULL
        )
      end
      log(:invoke)
    end
  end
end
