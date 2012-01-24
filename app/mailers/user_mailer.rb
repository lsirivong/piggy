class UserMailer < ActionMailer::Base
  default :from => 'Piggy App <thepiggyapp@gmail.com>'

  def activation_needed_email(user)
    @user = user
    mail(:to => @user.email,
      :subject => "Welcome to Piggy")
  end

  def activation_success_email(user)
    @user = user
    mail(:to => @user.email,
      :subject => "Piggy account activation")
  end
end
