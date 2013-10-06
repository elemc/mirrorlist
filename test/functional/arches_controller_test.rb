require 'test_helper'

class ArchesControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    login
    @arch = arches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arch" do
    assert_difference('Arch.count') do
      post :create, arch: { name: @arch.name }
    end

    assert_redirected_to arch_path(assigns(:arch))
  end

  test "should show arch" do
    get :show, id: @arch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @arch
    assert_response :success
  end

  test "should update arch" do
    put :update, id: @arch, arch: { name: @arch.name }
    assert_redirected_to arch_path(assigns(:arch))
  end

  test "should destroy arch" do
    assert_difference('Arch.count', -1) do
      delete :destroy, id: @arch
    end

    assert_redirected_to arches_path
  end
end
