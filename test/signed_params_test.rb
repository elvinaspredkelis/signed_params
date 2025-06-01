require "test_helper"

class SignedParamsTest < ActionDispatch::IntegrationTest
  test "with nil id" do
    assert_nil params.signed[:id]
    assert_raises ActionController::Parameters::InvalidSignature do
      params.signed.fetch(:id)
    end
  end

  test "with signed parameter id" do
    signed = params.sign(id: 1)
    assert_includes signed[:id], "==--"

    params = ActionController::Parameters.new(**signed)
    assert_equal 1, params.signed[:id]
    assert_equal 1, params.signed.fetch(:id)
  end

  test "pass signed params to URLs" do
    uri = URI post_url params.sign(id: 1, first_query_param: true, second_query_param: false)
    assert_match(/posts\/.*?==--/, uri.path)

    query = Rack::Utils.parse_query uri.query
    assert_equal 2, query.keys.size
    assert_match "--", query.fetch("first_query_param")
    assert_match "--", query.fetch("second_query_param")
  end

  test "extract signed params from controller" do
    get post_url(params.sign(id: 1))
    assert_equal 1, response.body.to_i
  end

  private
    def params = ActionController::Parameters.new
end
