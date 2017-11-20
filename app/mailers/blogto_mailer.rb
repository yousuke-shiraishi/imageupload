class BlogtoMailer < ApplicationMailer
 layout "mailer"

  def blogto_mail(blog)
    @blogtomail = blog
    mail(to: @blogtomail.email, subject: 'ブログが作成できました。')
  end
end
