ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :authentication => :plain,
    :domain => "gmail.com",
    :user_name => "hurrtzi",
    :password => "L0rdZ5ar",
    :enable_starttls_auto => true
}