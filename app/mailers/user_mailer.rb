class UserMailer < ApplicationMailer
    default from: "instagram@gmail.com"

    def send_welcome(user)
        mail(to: user.email, subject: "welcome to the instagram")
    end
end
