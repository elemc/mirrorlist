class Mirror < ActiveRecord::Base
  attr_accessible :description, :url, :country_code
  belongs_to :country

  def country
    c = Country.find_by_code( country_code )
    return "#{c.name} (#{c.code})" unless c.nil?
    ""
  end
end
