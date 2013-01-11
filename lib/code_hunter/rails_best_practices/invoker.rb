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
          "--output-file", RailsBestPractices::TEMPORAL_PATHNAME.to_s
        )
      end

      private

      def invoke_with_application_path
        Dir.chdir(application_path) do
          invoke_without_application_path
        end
      end
      alias_method_chain :invoke, :application_path

      def application_path
        options[:application_path] || "./"
      end
    end
  end
end
