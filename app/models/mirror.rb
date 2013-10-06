class Mirror < ActiveRecord::Base
  attr_accessible :description, :url, :country_code, :user_id
  belongs_to :country

  def country
    c = Country.find_by_code( country_code )
    return "#{c.name} (#{c.code})" unless c.nil?
    ""
  end

  def user_str( user )
    fallback_user = '### HIDDEN ###'
    u = User.find_by_id( user_id )
    return fallback_user if user.nil?
    if ( user.id == user_id  ) or ( user.admin? )
        return "#{u.email}" unless u.nil?
    else
        return fallback_user
    end
    ""
  end

end
