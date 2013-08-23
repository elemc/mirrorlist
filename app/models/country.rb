class Country < ActiveRecord::Base
  attr_accessible :code, :name
  has_many :mirrors
  has_many :stats
end

