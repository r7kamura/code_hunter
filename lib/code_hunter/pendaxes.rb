require "json"

module CodeHunter
  class Pendaxes
    extend MethodLogger

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def run
      summarize(invoke)
    end

    private

    def invoke
      `pendaxes-oneshot #{options[:application_path]} --reporter json 2>/dev/null `
    end
    log(:invoke)

    def summarize(json)
      pendings = JSON.parse(json)["pendings"]
      pendings.map do |pending|
        {
          :service => :pendaxes,
          :path    => pending["example"]["file"],
          :line    => pending["example"]["line"],
          :message => pending["example"]["message"],
        }
      end
    end
  end
end
