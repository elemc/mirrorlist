require 'test_helper'

class WorkaroundsControllerTest < ActionController::TestCase
  setup do
    login
    @workaround = workarounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workarounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workaround" do
    assert_difference('Workaround.count') do
      post :create, workaround: { key: @workaround.key, value: @workaround.value }
    end

    assert_redirected_to workaround_path(assigns(:workaround))
  end

  test "should show workaround" do
    get :show, id: @workaround
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workaround
    assert_response :success
  end

  test "should update workaround" do
    put :update, id: @workaround, workaround: { key: @workaround.key, value: @workaround.value }
    assert_redirected_to workaround_path(assigns(:workaround))
  end

  test "should destroy workaround" do
    assert_difference('Workaround.count', -1) do
      delete :destroy, id: @workaround
    end

    assert_redirected_to workarounds_path
  end
end
