mlp_lib = Rails.root.join 'lib', 'mirrorlistproceed.rb'
mlgi_lib = Rails.root.join 'lib', 'mirrorlistgeoip.rb'

require mlp_lib
require mlgi_lib
require 'thread'

class MirrorlistController < ApplicationController
    def index
        geoip = MirrorListGeoIP.new( request.remote_ip )
        out_c = params.key?( 'country' ) ? params['country'] : geoip.code

        Thread.new do
            founded = Stat.where('country_code=? AND city=? AND repo=? AND arch=?', geoip.code, geoip.city, params['repo'], params['arch'])
            if founded.size == 0
                Stat.new do |s|
                    s.country_code  = geoip.code
                    s.city          = geoip.city
                    if params.key? 'repo' and params.key? 'arch'
                        s.repo          = params['repo']
                        s.arch          = params['arch']
                    elsif params.key? 'path'
                        s.repo          = params['path']
                        s.arch          = 'path'
                    end
                    s.count         = 1
                    s.save
                end
            else
                founded.each do |f|
                    f.count += 1
                    f.save
                end
            end
        end if geoip.code.strip.size == 0

        if params.key? 'repo' and params.key? 'arch'
            mlp = MirrorListProceed.new( params['repo'], params['arch'], out_c )
        elsif params.key? 'path'
            mlp = MirrorListProceedPath.new( params['path'], out_c )
        else
            mpl = ""
        end

        if not params.key? 'output' or params['output'] == 'text'
            render :text => mlp.to_s, :content_type => :plaintext
        elsif params['output'] == 'html'
            @mirrorlist = mlp.to_s.split "\n"
            respond_to do |format|
                format.html # index.html.erb
                format.json { render json: @mirrorlist }
            end
        end

    end
end
