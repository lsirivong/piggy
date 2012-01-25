require 'test_helper'

class EnvelopesControllerTest < ActionController::TestCase
  setup do
    @envelope = envelopes(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create envelope" do
    assert_difference('Envelope.count') do
      post :create, envelope: @envelope.attributes
    end

    assert_redirected_to envelope_path(assigns(:envelope))
  end

  test "should show envelope" do
    get :show, id: @envelope.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @envelope.to_param
    assert_response :success
  end

  test "should update envelope" do
    put :update, id: @envelope.to_param, envelope: @envelope.attributes
    assert_redirected_to envelope_path(assigns(:envelope))
  end

  test "should destroy envelope" do
    assert_difference('Envelope.count', -1) do
      delete :destroy, id: @envelope.to_param
    end

    assert_redirected_to :root
  end

  test "should not show someone elses envelope" do
    get :show, id: envelopes(:two).to_param
    assert_redirected_to user_path(@current_user.id)
  end

  test "should not get edit for someone elses envelope" do
    get :edit, id: envelopes(:two).to_param
    assert_redirected_to user_path(@current_user.id)
  end

  test "should not update someone elses envelope" do
    put :update, id: envelopes(:two), envelope: @envelope.attributes
    assert_redirected_to user_path(@current_user.id)
  end

  test "should not destroy someone elses envelope" do
    assert_no_difference('Envelope.count') do
      delete :destroy, id: envelopes(:two).to_param
    end

    assert_redirected_to user_path(@current_user.id)
  end
end
