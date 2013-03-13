module CodeHunter
  module MethodLogger
    def log(method_name)
      define_method("#{method_name}_with_log") do |*args, &block|
        warn("#{Time.now} #{self.class}##{method_name}") if Config.enable_logger
        __send__("#{method_name}_without_log", *args, &block)
      end
      alias_method_chain method_name, :log
    end
  end
end
