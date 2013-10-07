class Mirror < ActiveRecord::Base
  attr_accessible :description, :url, :country_code, :user_id, :enabled
  belongs_to :country
  before_save :check_and_set_enabled

  def country
    c = Country.find_by_code( country_code )
    return "#{c.name} (#{c.code})" unless c.nil?
    ""
  end

  def user_str( user )
    fallback_user = '### HIDDEN ###'
    u = User.find_by_id( user_id )
    return fallback_user if user.nil?
    if is_my_mirror? user
        return "#{u.email}" unless u.nil?
    else
        return fallback_user
    end
    ""
  end

  def is_my_mirror?( user )
    return false if ( user.nil? )
    u = User.find_by_id( user_id )
    return true if ( user.id == user_id  ) or ( user.admin? )
    false
  end

  private

  def check_and_set_enabled
    return unless self.enabled.nil?

    self.enabled = false
    return nil

  end

end
