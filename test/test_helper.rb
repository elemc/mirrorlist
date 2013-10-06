ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActionController::TestCase
  include Devise::TestHelpers
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Devise::TestHelpers
  def login
    @user = User.new( {
        :email => "abc@ror-test-cases123.tld",
        :password => "1240user",
        :password_confirmation => "1240user",
        :role => "admin", }
        )
    @user.skip_confirmation!
    @user.save!
    sign_in @user
    @user
  end
end
