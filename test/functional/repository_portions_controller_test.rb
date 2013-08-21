require 'test_helper'

class RepositoryPortionsControllerTest < ActionController::TestCase
  setup do
    @repository_portion = repository_portions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repository_portions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repository_portion" do
    assert_difference('RepositoryPortion.count') do
      post :create, repository_portion: { name: @repository_portion.name, url_part: @repository_portion.url_part }
    end

    assert_redirected_to repository_portion_path(assigns(:repository_portion))
  end

  test "should show repository_portion" do
    get :show, id: @repository_portion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repository_portion
    assert_response :success
  end

  test "should update repository_portion" do
    put :update, id: @repository_portion, repository_portion: { name: @repository_portion.name, url_part: @repository_portion.url_part }
    assert_redirected_to repository_portion_path(assigns(:repository_portion))
  end

  test "should destroy repository_portion" do
    assert_difference('RepositoryPortion.count', -1) do
      delete :destroy, id: @repository_portion
    end

    assert_redirected_to repository_portions_path
  end
end
