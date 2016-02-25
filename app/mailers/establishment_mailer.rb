class EstablishmentMailer < ActionMailer::Base
  default from: "from@example.com"

  def daily_email(specials)
    # mail(to: @{target_user.email, subject: 'Welcome to BarFly!')
    @specials = specials
    mail(to: "phillip.lisovicz@gmail.com", subject: 'Welcome to BarFly!')
  end

  def weekly_email
    # @user = user
    # @url  = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    mail(to: "phillip.lisovicz@gmail.com", subject: 'Welcome to BarFly!')
  end

end
