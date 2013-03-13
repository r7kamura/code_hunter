module CodeHunter
  module Config
    class << self
      attr_accessor :enable_logger

      def reset
        self.enable_logger = true
      end
    end

    reset
  end
end
