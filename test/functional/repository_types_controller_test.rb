require 'test_helper'

class RepositoryTypesControllerTest < ActionController::TestCase
  setup do
    @repository_type = repository_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repository_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repository_type" do
    assert_difference('RepositoryType.count') do
      post :create, repository_type: { path_part: @repository_type.path_part, rtype: @repository_type.rtype }
    end

    assert_redirected_to repository_type_path(assigns(:repository_type))
  end

  test "should show repository_type" do
    get :show, id: @repository_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repository_type
    assert_response :success
  end

  test "should update repository_type" do
    put :update, id: @repository_type, repository_type: { path_part: @repository_type.path_part, rtype: @repository_type.rtype }
    assert_redirected_to repository_type_path(assigns(:repository_type))
  end

  test "should destroy repository_type" do
    assert_difference('RepositoryType.count', -1) do
      delete :destroy, id: @repository_type
    end

    assert_redirected_to repository_types_path
  end
end
