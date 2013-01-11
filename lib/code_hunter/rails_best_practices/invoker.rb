module CodeHunter
  class RailsBestPractices
    class Invoker
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def invoke
        system(
          "rails_best_practices",
          "--format", "html",
          "--output-file", RailsBestPractices::TEMPORAL_PATHNAME.to_s,
          :out => File::NULL,
          :err => File::NULL,
        )
      end
    end
  end
end
