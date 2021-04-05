class UserMailer < ApplicationMailer
    def new_registration_email(user)
        @user = user
        mail subject: '新規アカウント登録されました', to: @user.email
    end
end