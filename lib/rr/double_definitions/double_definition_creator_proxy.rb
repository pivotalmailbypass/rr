module RR
  module DoubleDefinitions
    class DoubleDefinitionCreatorProxy
      def initialize(creator, &block) #:nodoc:
        @creator = creator
        class << self
          instance_methods.each do |m|
            unless m =~ /^_/ || m.to_s == 'object_id'
              undef_method m
            end
          end

          def method_missing(method_name, *args, &block)
            @creator.create(method_name, *args, &block)
          end
        end
        yield(self) if block_given?
      end

      def __creator__
        @creator
      end
    end    
  end
end