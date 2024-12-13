require "test_helper"

class RoutesTest < ActionDispatch::IntegrationTest
  test "should route to events index" do
    assert_routing "/events", controller: "events", action: "index"
  end

  test "should route to checkout create" do
    assert_routing({ path: "/checkout/create", method: :post }, controller: "checkout", action: "create")
  end
end
