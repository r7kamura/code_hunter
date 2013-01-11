require "nokogiri"

module CodeHunter
  class Brakeman
    class Summarizer
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def summarize
        warning_elements.map do |element|
          {
            :service => "brakeman",
            :line    => find_line(element),
            :path    => find_path(element),
            :message => find_message(element),
          }
        end
      end

      def find_line(element)
        find_message(element)[/near line (\d+)/, 1].try(:to_i)
      end

      def find_message(element)
        element.child.text.strip
      end

      def find_path(element)
        element.css("caption").text.strip
      end

      def warning_elements
        tree.css(".warning_message")
      end

      def tree
        Nokogiri.HTML(content)
      end

      def content
        Brakeman::TEMPORAL_PATHNAME.read
      end

      def summarize_with_file_existence_check
        if Brakeman::TEMPORAL_PATHNAME.exist?
          summarize_without_file_existence_check
        else
          warn "Brakeman output file is not found"
        end
      end
      alias_method_chain :summarize, :file_existence_check
    end
  end
end
