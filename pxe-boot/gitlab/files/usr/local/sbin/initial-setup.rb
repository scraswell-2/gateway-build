#!/usr/bin/env ruby

#User.create!(
#    :name => "",
#    :username => "",
#    :email => "",
#    :password => "",
#    :password_confirmation => "",
#    :admin => true)

puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token
