require 'net/http'

class Country < ActiveRecord::Base
  attr_accessible :code, :name

end

