require 'test_helper'

class MirrorlistControllerTest < ActionController::TestCase
  test "should get repos" do
    get :index, repo: 'free-fedora-updates-testing-19'
    assert_response :success
  end
end
