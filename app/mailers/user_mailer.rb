class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, 
      subject: 'Your account has been deleted' )
  end
end
