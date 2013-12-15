ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "henriknafo@gmail.com",
  :password             => "hnmatrix7374908",
  :authentication       => "plain",
  :enable_starttls_auto => true
}