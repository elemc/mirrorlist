mlp_lib = Rails.root.join 'lib', 'mirrorlistproceed.rb'
require mlp_lib

class MirrorlistController < ApplicationController
    def index
        mlp = MirrorListProceed.new( params['repo'], params['arch'] )
        render :text => mlp.to_s, :content_type => :plaintext
    end
end
