require 'active_support/concern'
require 'fluent/validation/version'

module Fluent
  module Validation
    extend ActiveSupport::Concern

    class_methods do
      def attributes
        @attributes ||= []
        return @attributes
      end

      def mandatories(*fields)
        fields.each do |field|
          if field.is_a?(Hash)
            self.mandatory(field.keys[0], field.values[0])
          else
            self.mandatory(field)
          end
        end
      end

      def optionals(*fields)
        fields.each do |field|
          if field.is_a?(Hash)
            self.optional(field.keys[0], field.values[0])
          else
            self.optional(field)
          end
        end
      end

      def mandatory(field, options={})
        self.attributes << field
        self.validates(field, options.merge(presence: true))
      end

      def optional(field, options={})
        self.attributes << field
        self.validates(field, options)
      end
    end
  end
end
