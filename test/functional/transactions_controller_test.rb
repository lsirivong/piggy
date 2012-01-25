require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  setup do
    @transaction = transactions(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post :create, transaction: @transaction.attributes
    end

    assert_redirected_to transaction_path(assigns(:transaction))
  end

  test "should show transaction" do
    get :show, id: @transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transaction.to_param
    assert_response :success
  end

  test "should update transaction" do
    put :update, id: @transaction.to_param, transaction: @transaction.attributes
    assert_redirected_to :root
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete :destroy, id: @transaction.id
    end

    assert_redirected_to :root
  end

  test "should not show someone elses transaction" do
    get :show, id: transactions(:two).to_param
    assert_redirected_to user_path(@current_user.id)
  end

  test "should not get edit for someone elses transaction" do
    get :edit, id: transactions(:two).to_param
    assert_redirected_to user_path(@current_user.id)
  end

  test "should not update someone elses transaction" do
    put :update, id: transactions(:two).to_param, transaction: @transaction.attributes
    assert_redirected_to user_path(@current_user.id)
  end

  test "should not destroy someone elses transaction" do
    assert_no_difference('Transaction.count') do
      delete :destroy, id: transactions(:two).id
    end

    assert_redirected_to user_path(@current_user.id)
  end
end
