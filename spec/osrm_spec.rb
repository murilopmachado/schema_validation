require_relative './spec_helper'


describe "Check for coordinates from OSRM App" do

  # Loading valid and invalid schemas
  before(:all) do
    @driving_route_schema = JSON.parse(File.read('./data/schemas/driving_route_schema.json'))
    @invalid_driving_route_schema = JSON.parse(File.read('./data/schemas/invalid_driving_route_schema.json'))
  end

  # Constructing the requests used for each tests
  before(:each) do
    @request      = Requestor.new
    @request.host = DATA['host']['osrm']
    @request.method       = 'get'
    @request.query_params = DATA['query_params']['routing_method']
  end

  # Checking status code 200 and the response schema for a valid request
  it "Execute valid routing requests with success using valid coordinates" do
    @coordinates     = DATA['regular_test_data']['valid_coordinates']
    @request.path    = ERB.new(DATA['path']['driving_route']).result(binding)
    request_response = @request.execute
    body             = JSON.parse(request_response['response'].body)

    SchemaValidator.validate(
      schema: @driving_route_schema,
      body:   body
    )
    expect(request_response['response'].code).to eq(200)
    expect(body['code']).to eq('Ok')
    expect(body.keys).to contain_exactly('code', 'routes', 'waypoints')
  end

  # Checking status code 400 and the response schema for an invalid request
  it "Execute invalid routing requests with failure using invalid coordinates" do
    @coordinates     = DATA['regular_test_data']['invalid_coordinates']
    @request.path    = ERB.new(DATA['path']['driving_route']).result(binding)
    request_response = @request.execute
    body             = JSON.parse(request_response['response'].body)

    SchemaValidator.validate(
      schema: @invalid_driving_route_schema,
      body:   body
    )
    expect(request_response['response'].code).to eq(400)
    expect(body['code']).to eq('InvalidQuery')
    expect(body.keys).to contain_exactly('code', 'message')
  end

end



