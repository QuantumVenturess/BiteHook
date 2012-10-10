require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get how_works" do
    get :how_works
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
