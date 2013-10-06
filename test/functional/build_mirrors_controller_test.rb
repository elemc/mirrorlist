require 'test_helper'

class BuildMirrorsControllerTest < ActionController::TestCase
  setup do
    login
    @build_mirror = build_mirrors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:build_mirrors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create build_mirror" do
    assert_difference('BuildMirror.count') do
      post :create, build_mirror: { description: @build_mirror.description, url: @build_mirror.url }
    end

    assert_redirected_to build_mirror_path(assigns(:build_mirror))
  end

  test "should show build_mirror" do
    get :show, id: @build_mirror
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @build_mirror
    assert_response :success
  end

  test "should update build_mirror" do
    put :update, id: @build_mirror, build_mirror: { description: @build_mirror.description, url: @build_mirror.url }
    assert_redirected_to build_mirror_path(assigns(:build_mirror))
  end

  test "should destroy build_mirror" do
    assert_difference('BuildMirror.count', -1) do
      delete :destroy, id: @build_mirror
    end

    assert_redirected_to build_mirrors_path
  end
end
