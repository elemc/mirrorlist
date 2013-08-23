mlp_lib = Rails.root.join 'lib', 'mirrorlistproceed.rb'
mlgi_lib = Rails.root.join 'lib', 'mirrorlistgeoip.rb'

require mlp_lib
require mlgi_lib
require 'thread'

class MirrorlistController < ApplicationController
    def index
        geoip = MirrorListGeoIP.new( 'mirrors.rfremix.ru' ) #request.remote_ip )
        out_c = params['country'] ? params.key?( 'country' ) : geoip.code

        # TODO: create scaffold for stats
        Thread.new do 
            founded = Stat.where('country_code=? AND city=? AND repo=? AND arch=?', geoip.code, geoip.city, params['repo'], params['arch'])
            if founded.size == 0
                Stat.new do |s|
                    s.country_code  = geoip.code
                    s.city          = geoip.city
                    s.repo          = params['repo']
                    s.arch          = params['arch']
                    s.count         = 1
                    s.save
                end
            else
                founded.each do |f|
                    f.count += 1
                    f.save
                end
            end
        end

        mlp = MirrorListProceed.new( params['repo'], params['arch'], out_c )
        render :text => mlp.to_s, :content_type => :plaintext
    end
end
