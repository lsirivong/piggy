require 'test_helper'

class GoalsControllerTest < ActionController::TestCase
  setup do
    @goal = goals(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goal" do
    assert_difference('Goal.count') do
      post :create, goal: @goal.attributes
    end

    assert_redirected_to :root
  end

  test "should show goal" do
    get :show, id: @goal.to_param
    assert_response :success
  end

  test "should not show someone elses goal" do
    get :show, id: goals(:daves_goal).to_param
    assert_redirected_to user_path(@current_user.id)
  end

  test "should get edit" do
    get :edit, id: @goal.to_param
    assert_response :success
  end

  test "should not edit someone elses goal" do
    get :edit, id: goals(:daves_goal).to_param
    assert_redirected_to user_path(@current_user.id)
  end

  test "should update goal" do
    put :update, id: @goal.to_param, goal: @goal.attributes
    assert_redirected_to :root
  end

  test "should not update someone elses goal" do
    put :update, id: goals(:daves_goal).to_param
    assert_redirected_to user_path(@current_user.id)
  end

  test "should destroy goal" do
    assert_difference('Goal.count', -1) do
      delete :destroy, id: @goal.to_param
    end

    assert_redirected_to :root
  end

  test "should not destroy someone elses goal" do
    assert_no_difference('Goal.count') do
      delete :destroy, id: goals(:daves_goal).to_param
    end

    assert_redirected_to user_path(@current_user.id)
  end
end
