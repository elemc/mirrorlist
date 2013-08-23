mlp_lib = Rails.root.join 'lib', 'mirrorlistproceed.rb'
require mlp_lib
require 'geoip'

class MirrorlistController < ApplicationController
    def index
        out_c = ''
        out_c = params['country'] if params.key? 'country'
    
        unless params.key? 'country'
            begin
                geo = GeoIP.new Rails.root.join('lib/GeoIP.dat')
                country_object = geo.country request.remote_ip
            rescue
                out_c = 'RU'
            else
                out_c = country_object.country_code2
            end
        end
    
        mlp = MirrorListProceed.new( params['repo'], params['arch'], out_c )
        render :text => mlp.to_s, :content_type => :plaintext
    end
end
