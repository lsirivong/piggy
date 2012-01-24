class UserMailer < ActionMailer::Base
  default :from => 'Piggy App <thepiggyapp@gmail.com>'

  def activation_needed_email(user)
    @user = user
    # @url = "#{request.host_with_port}/users/#{user.activation_token}/activate"
    mail(:to => @user.email,
      :subject => "Welcome to Piggy")
  end

  def activation_success_email(user)
    @user = user
    @url = "http://0.0.0.0:3000/login"
    mail(:to => @user.email,
      :subject => "Piggy account activation")
  end
end
