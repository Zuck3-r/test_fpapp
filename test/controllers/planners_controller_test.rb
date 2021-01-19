require 'test_helper'

class PlannersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get planners_new_url
    assert_response :success
  end

end
