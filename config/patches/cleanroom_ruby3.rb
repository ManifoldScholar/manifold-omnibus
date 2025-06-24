# Monkey patch for cleanroom gem Ruby 3 compatibility
# Place this in your omnibus project before cleanroom is used

module Cleanroom
  module ClassMethods
    def cleanroom
      exposed = exposed_methods.keys
      parent = self.name || 'Anonymous'

      Class.new(Object) do
        class << self
          def class_eval
            raise Cleanroom::InaccessibleError.new(:class_eval, self)
          end

          def instance_eval
            raise Cleanroom::InaccessibleError.new(:instance_eval, self)
          end
        end

        define_method(:initialize) do |instance|
          define_singleton_method(:__instance__) do
            unless caller[0].include?(__FILE__)
              raise Cleanroom::InaccessibleError.new(:__instance__, self)
            end

            instance
          end
        end

        exposed.each do |exposed_method|
          define_method(exposed_method) do |*args, **kwargs, &block|
            # Ruby 3 compatible method call
            if kwargs.empty?
              __instance__.public_send(exposed_method, *args, &block)
            else
              __instance__.public_send(exposed_method, *args, **kwargs, &block)
            end
          end
        end

        define_method(:class_eval) do
          raise Cleanroom::InaccessibleError.new(:class_eval, self)
        end

        define_method(:inspect) do
          "#<#{parent} (Cleanroom)>"
        end
        alias_method :to_s, :inspect
      end
    end
  end
end

# Apply the patch by prepending the module
if defined?(Cleanroom)
  Cleanroom.singleton_class.prepend(Cleanroom::ClassMethods)
end
