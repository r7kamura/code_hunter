require "nokogiri"

module CodeHunter
  class RailsBestPractices
    class Summarizer
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def summarize
        warning_elements.map do |element|
          {
            :line => find_line(element),
            :path => find_path(element),
          }
        end
      end

      def find_line(element)
        element.css(".line").text.strip.to_i
      end

      def find_path(element)
        File.join(
          application_path,
          element.css(".filename").text.strip
        )
      end

      def warning_elements
        tree.css(".result tbody tr")
      end

      def tree
        Nokogiri.HTML(content)
      end

      def content
        RailsBestPractices::TEMPORAL_PATHNAME.read
      end

      def application_path
        options[:application_path] || "./"
      end

      def summarize_with_file_existence_check
        if RailsBestPractices::TEMPORAL_PATHNAME.exist?
          summarize_without_file_existence_check
        else
          warn "RailsBestPractices output file is not found"
        end
      end
      alias_method_chain :summarize, :file_existence_check
    end
  end
end
