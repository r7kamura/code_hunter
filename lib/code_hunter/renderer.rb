require "json"
require "yaml"

module CodeHunter
  # Render warnings to string with the specified format.
  # As its format, AVAILABLE_FORMATS are available ("yaml" is default).
  class Renderer
    AVAILABLE_FORMATS = %w[json yaml]

    def self.render(*args)
      new(*args).render
    end

    def initialize(warnings, options = {})
      @warnings = warnings
      @format   = options[:format] || "yaml"
    end

    def render
      case format
      when "yaml"
        @warnings.to_yaml
      when "json"
        JSON.unparse(@warnings)
      else
        raise ArgumentError, "format #{format} is not available. Use #{AVAILABLE_FORMATS}"
      end
    end

    private

    def format
      @format.to_s
    end
  end
end
