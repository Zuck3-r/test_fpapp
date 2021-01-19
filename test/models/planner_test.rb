require 'test_helper'

class PlannerTest < ActiveSupport::TestCase

  def setup
    @planner = Planner.new(name: "Gojo Satoru", email: "example@gmail.com",
                          password: "hogefuga", password_confirmation: "hogefuga")
  end

  test "should be valid" do
    assert @planner.valid?
  end

  test "name should be present" do
    @planner.name = "    "
    assert_not @planner.valid?
  end
  
  test "email should be present" do
    @planner.email = "   "
    assert_not @planner.valid?
  end
  
  test "email should not too long" do
    @planner.email = "a"*256+"@example.com"
    assert_not @planner.valid?
  end
end