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
end
