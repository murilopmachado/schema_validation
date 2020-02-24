require "json-schema"
require_relative './unique_items_patch'

class SchemaValidator
  class << self
    def validate(schema:, body:)
      begin
        JSON::Validator.validate!(schema, body)
      rescue JSON::Schema::ValidationError => e
        raise(
          SchemaInvalidAttributesException,
          "Invalid attributes found" \
          "\n#{e.message}"
        )
      end
    end
  end
end

SchemaInvalidAttributesException = Class.new(StandardError)
