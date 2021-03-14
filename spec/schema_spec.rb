require_relative './spec_helper'

describe "Posts endpoint" do

  # Loading valid and invalid schema
  before(:all) do
    @posts_schema = JSON.parse(File.read('./data/schemas/posts_schema.json'))
    @invalid_posts_schema = JSON.parse(File.read('./data/schemas/invalid_posts_schema.json'))
  end

  # Checking status code 200 and the response schema for a valid request
  # Negative example
  it "Check posts endpoint status and response schema" do

    # GET Request
    response = Faraday.get("#{DATA['host']['base']}#{DATA['path']['posts']}")

    # Check HTTP status code
    expect(response.status).to eq(200)

    # Compare response over schema
    SchemaValidator.validate(
      schema: @invalid_posts_schema,
      body:   response.body
    )

  end

  # Positive example
  it "Check posts endpoint status and response schema" do
    response = Faraday.get("#{DATA['host']['base']}#{DATA['path']['posts']}")

    SchemaValidator.validate(
      schema: @posts_schema,
      body:   response.body
    )
    expect(response.status).to eq(200)
  end

end



