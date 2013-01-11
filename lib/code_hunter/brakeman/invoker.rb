module CodeHunter
  class Brakeman
    class Invoker
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def invoke
        system(
          "brakeman",
          "--output", Brakeman::TEMPORAL_PATHNAME.to_s
        )
      end
    end
  end
end
