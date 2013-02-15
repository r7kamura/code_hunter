require "optparse"

module CodeHunter
  class OptionParser < ::OptionParser
    OPTIONS = [
      "--application-path=",       "(default:    ./) rails application root path",
      "--format=",                 "(default:  yaml) output format (yaml or json)",
      "--no-brakeman",             "(default: false) disable brakeman",
      "--no-pendaxes",             "(default: false) disable pendaxes",
      "--no-rails-best-practices", "(default: false) disable rails-best-practices",
    ]

    def self.parse!(argv)
      new.parse!(argv)
    end

    def self.help
      new.help
    end

    def initialize(*)
      super
      configure_options
    end

    def parse!(*)
      super
      options
    end

    def options
      @options ||= { :application_path => "./" }
    end

    private

    def configure_options
      arguments.each do |argument|
        on(argument.key, argument.description) do |value|
          options[argument.to_sym] = value
        end
      end
    end

    def arguments
      OPTIONS.each_slice(2).map do |key, description|
        Argument.new(key, description)
      end
    end

    class Argument
      attr_reader :key, :description

      def initialize(key, description)
        @key         = key
        @description = description
      end

      def to_sym
        str = @key
        str = without_head_hyphen(str)
        str = without_head_no(str)
        str = without_last_equal(str)
        str = underscored(str)
        str.to_sym
      end

      private

      def underscored(str)
        str.gsub("-", "_")
      end

      def without_head_hyphen(str)
        str.gsub(/^--/, "")
      end

      def without_head_no(str)
        str.gsub(/^no-/, "")
      end

      def without_last_equal(str)
        str.gsub(/=$/, "")
      end
    end
  end
end
