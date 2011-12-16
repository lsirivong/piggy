require 'test_helper'

class BudgetsControllerTest < ActionController::TestCase
  setup do
    @budget = budgets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:budgets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create budget" do
    assert_difference('Budget.count') do
      post :create, budget: @budget.attributes
    end

    assert_redirected_to budget_path(assigns(:budget))
  end

  test "should show budget" do
    get :show, id: @budget.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @budget.to_param
    assert_response :success
  end

  test "should update budget" do
    put :update, id: @budget.to_param, budget: @budget.attributes
    assert_redirected_to budget_path(assigns(:budget))
  end

  test "should destroy budget" do
    assert_difference('Budget.count', -1) do
      delete :destroy, id: @budget.to_param
    end

    assert_redirected_to budgets_path
  end
end
