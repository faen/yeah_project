ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "enterat.de",  
  :user_name            => "fabian.englaender@enterat.de",  
  :password             => "0ddc0de5!",  
  :authentication       => "plain",  
  :enable_starttls_auto => true
}