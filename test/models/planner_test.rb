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
  
  test "name should not be too long" do
    @planner.name = "a"*41
    assert_not @planner.valid?
  end
  
  test "email should be present" do
    @planner.email = "   "
    assert_not @planner.valid?
  end
  
  test "email should not be too long" do
    @planner.email = "a"*256+"@example.com"
    assert_not @planner.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_planner = @planner.dup
    @planner.save
    duplicate_planner.email = @planner.email.upcase
    assert_not duplicate_planner.valid?
  end
  
  test "password should not be present(noblank)" do
    @planner.password = "          "
    assert_not @planner.valid?
  end
  
  test "password should not be too short" do
    @planner.password = "foo"
    assert_not @planner.valid?
  end
end