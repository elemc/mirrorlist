mlp_lib = Rails.root.join 'lib', 'mirrorlistproceed.rb'
mlgi_lib = Rails.root.join 'lib', 'mirrorlistgeoip.rb'

require mlp_lib
require mlgi_lib

class MirrorlistController < ApplicationController
    def index
        geoip = MirrorListGeoIP.new( request.remote_ip )
        out_c = params['country'] ? params.key?( 'country' ) : geoip.code

        # TODO: create scaffold for stats

        mlp = MirrorListProceed.new( params['repo'], params['arch'], out_c )
        render :text => mlp.to_s, :content_type => :plaintext
    end
end
