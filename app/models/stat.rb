class Stat < ActiveRecord::Base
  attr_accessible :arch, :city, :count, :country_code, :repo
  belongs_to :country

  def country
    c = Country.find_by_code( country_code )
    return "#{c.name} (#{c.code})" unless c.nil?
    ""
  end
end
