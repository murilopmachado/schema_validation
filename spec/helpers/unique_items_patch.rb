# Monkey Patch created to handle Array validations with duplicated values from
# routes.0.legs.0.steps.0.intersections.1.entry Array values
# The default behaviour when using json-schema validator gem is to handle
# duplicated values from same array as an exception, which in our case is not an
# exception.
require 'json-schema/attribute'

module JSON
  class Schema
    class UniqueItemsAttribute < Attribute
      def self.validate(current_schema, data, fragments, processor, validator, options = {})
        return unless data.is_a?(Array)

        if data.clone.uniq!
          message = "The property '#{build_fragment(fragments)}' contained duplicated array values"
        #   validation_error(processor, message, fragments, current_schema, self, options[:record_errors])
        end
      end
    end
  end
end
