require 'test_helper'

class RepositoryVariantsControllerTest < ActionController::TestCase
  setup do
    @repository_variant = repository_variants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repository_variants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repository_variant" do
    assert_difference('RepositoryVariant.count') do
      post :create, repository_variant: { name: @repository_variant.name, url: @repository_variant.url }
    end

    assert_redirected_to repository_variant_path(assigns(:repository_variant))
  end

  test "should show repository_variant" do
    get :show, id: @repository_variant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repository_variant
    assert_response :success
  end

  test "should update repository_variant" do
    put :update, id: @repository_variant, repository_variant: { name: @repository_variant.name, url: @repository_variant.url }
    assert_redirected_to repository_variant_path(assigns(:repository_variant))
  end

  test "should destroy repository_variant" do
    assert_difference('RepositoryVariant.count', -1) do
      delete :destroy, id: @repository_variant
    end

    assert_redirected_to repository_variants_path
  end
end
