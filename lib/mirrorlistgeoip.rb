#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-
# -*-      Ruby     -*-
# ------------------------------------ #
# Ruby source class (Object)           #
# Author: Alexei Panov <me@elemc.name> #
# ------------------------------------ #
# Description: 

require 'geoip'

DATABASE_DIR        = Rails.root.join('lib', 'geoip')
COUNTRY_DATABASE    = DATABASE_DIR.join('GeoIP.dat')
CITY_DATABASE       = DATABASE_DIR.join('GeoLiteCity.dat')

COUNTRY_URL         = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
CITY_URL            = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'

class MirrorListGeoIP < Object
    attr_reader :ip
    attr_reader :code
    attr_reader :name
    attr_reader :city
    attr_reader :timezone

    def initialize( ip_addr )
        init_data

        @ip_addr = ip_addr
        city = GeoIP.new CITY_DATABASE
        city_data = city.city( ip_addr )
        @is_ok = false

    rescue
        rescue_variables
    else
        if city_data.nil?
            rescue_variables
            return
        end
        @ip         = city_data.ip
        @code       = city_data.country_code2
        @name       = city_data.country_name
        @city       = city_data.city_name
        @timezone   = city_data.timezone
        @is_ok      = true
    end

    def to_s
        @country_data.to_hash
        ""
    end

    private

    def init_data
        unless File.exists? COUNTRY_DATABASE
            `pushd #{DATABASE_DIR}; wget #{COUNTRY_URL}; gzip -d GeoIP.dat.gz; popd`
        end
        unless File.exists? CITY_DATABASE
            `pushd #{DATABASE_DIR}; wget #{CITY_URL}; gzip -d GeoLiteCity.dat.gz; popd`
        end
    end

    def rescue_variables
        @ip         = @ip_addr
        @code       = '--'
        @name       = 'Unknown'
        @city       = 'Unknown'
        @timezone   = 'UTC'
    end
end

