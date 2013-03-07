module CodeHunter
  class Brakeman
    class Invoker
      extend MethodLogger

      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def invoke
        system(
          "brakeman",
          "--output", Brakeman::TEMPORAL_PATHNAME.to_s,
          :out => IO::NULL,
          :err => IO::NULL
        )
      end
      log(:invoke)
    end
  end
end
