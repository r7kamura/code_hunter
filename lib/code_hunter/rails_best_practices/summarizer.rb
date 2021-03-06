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
            :service => "rails_best_practices",
            :line    => find_line(element),
            :path    => find_path(element),
            :message => find_message(element),
            :url     => find_url(element),
          }
        end
      end

      def find_line(element)
        element.css(".line").text.strip.to_i
      end

      def find_path(element)
        element.css(".filename").text.strip
      end

      def find_message(element)
        element.css(".message").text.strip
      end

      def find_url(element)
        element.css("a").first.try(:attr, "href")
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
    end
  end
end
