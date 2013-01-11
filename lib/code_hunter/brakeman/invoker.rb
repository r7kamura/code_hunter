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
          "--output", Brakeman::TEMPORAL_PATHNAME.to_s,
          :out => File::NULL,
          :err => File::NULL
        )
      end
    end
  end
end
