require "json-schema"

class SchemaValidator
  class << self
    def validate(schema:, body:)
      begin
        JSON::Validator.validate!(schema, body)
      rescue JSON::Schema::ValidationError => e
        raise(
          SchemaInvalidAttributesException,
          "Invalid attributes found",
          e.message
        )
      end
    end
  end
end

SchemaInvalidAttributesException = Class.new(StandardError)
