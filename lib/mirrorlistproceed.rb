#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-
# -*-      Ruby     -*-
# ------------------------------------ #
# Ruby source class (Object)           #
# Author: Alexei Panov <me@elemc.name> #
# ------------------------------------ #
# Description: 


class MirrorListProceed < Object
    def initialize( repo, arch, country=nil )
        @repo = repo
        @arch = arch
        @country = country
        @mlist = []

        init_mlist

        # arches
        return unless Arch.find_by_name @arch

        # workarounds
       workaround = Workaround.find_by_key @repo

        unless workaround.nil?
            if @repo.include? 'build'
                @mirrors_list = BuildMirror.all
            end
            Mirror.all.each do |m|
                val = workaround.value
                port = val.sub! "$arch$", @arch
                wl = URI.join( m, port )
                @mlist << wl
            end
            return
        end

        @repo_type = ''
        @repo_params = {}
        init_repo
        generate_main_list
    end

    def to_s
        @mlist.join( "\n" )
    end

    private

    def init_repo
        arch = @arch
        repo_split = @repo.split '-'
        return nil if repo_split.size == 0

        # Repository type
        repo_type = repo_split[0]
        return nil unless RepositoryType.find_by_rtype repo_type

        # Version
        version,next_pos = get_version_from_repo( repo_split )

        # repo
        repo = repo_split[1..next_pos].join( '-' )

        # first check 'fedora'
        return nil unless repo.include? 'fedora'

        variant, portion = get_me_varian_and_portion repo

        md_list = ['main', 'development']
        
        # second checks
        if portion == 'main'
            portion = '' unless md_list.include? variant
        elsif portion == 'source'
            portion = ''
            arch = md_list.include? variant ? 'source/SRPMS' : 'SRPMS'
        end

        version_record = Release.find_by_name version
        return nil if version_record.nil?
        variant = 'development' unless version_record.stable
    
        variant_db  = RepositoryVariant.find_by_name variant
        repo_db     = RepositoryType.find_by_rtype repo_type
        portion_db  = RepositoryPortion.find_by_name portion if portion.size > 0

        return nil if variant_db.nil? or repo_db.nil?
        return nil if portion.size != 0 and portion_db.nil?

        @repo_params['variant']     = variant_db.url
        @repo_params['repos']       = repo_db.path_part
        @repo_params['portion']     = portion_db.nil? ? portion : portion_db.url_part
        @repo_params['arch']        = arch
        @repo_params['version']     = version
    end

    def get_mirrors_array
        unless @country.nil?
            c = Country.find_by_code @country
            unless c.nil?
                result_list = Mirror.where( country_code: @country )
                result_list += Mirror.where( "country_code != ?", @country )
                return result_list
            end
        end

        Mirror.all              
    end

    def generate_main_list
        return nil unless @repo_params.key? 'variant'
        get_mirrors_array.each do |mirror_db|
            mirror = mirror_db.url
            variant = @repo_params['variant']
            str_to_add = variant.sub '$mirror$', mirror
            @repo_params.keys.each do |key|
                next if key == 'variant'
                sub_str = "$#{key}$"
                value = @repo_params[key]
                str_to_add.sub! sub_str, value
                str_to_add = clear_slashes! str_to_add
           end
           @mlist << str_to_add
         end
    end

    def get_me_varian_and_portion( repo )
        match5 = test_and_get_regexp( /.*fedora-updates-(.*)-(.*)/, repo ) 
        unless match5.nil?
            return generate_updates_vp match5[1], match5[2]
        end

        match4 = test_and_get_regexp( /.*fedora-updates-(.*)/, repo )
        unless match4.nil?
            return generate_updates_vp match4[1]
        end

        match3 = test_and_get_regexp( /.*fedora-(.*)/, repo )
        unless match3.nil?
            return ['main', match3[1]]
        end

        if repo == 'fedora'
            return ['main', 'main']
        end

        nil
    end

    def generate_updates_vp( tr, port = 'main' )
        variant = tr == 'testing' ? "updates-#{tr}" : 'updates'
        portion = port
        return [variant, portion]
    end

    def test_and_get_regexp( regexp, repo )
        m = regexp.match repo
        return nil if m.nil?
        m
    end

    def add_countries_to_mlist
        # FIXME: It's old style 
        # Language.all.each { |lang| init_str += " country = #{lang.name}" }
        # New style:
        result_str = " country = #{@country}" unless @country.nil?
    end

    def init_mlist
        init_str = "# repo = #{@repo} arch = #{@arch}"
        init_str += add_countries_to_mlist
        @mlist << init_str
    end

    def get_version_from_repo( repo )
        temp_ver = repo[-1]
        return [temp_ver, -2] if temp_ver.upcase == "RAWHIDE"
        if temp_ver.to_i.to_s != temp_ver # Alpha, Beta, .1
            if temp_ver.to_f.to_s != temp_ver # Alpha, Beta
                return [repo[-2..-1].join('-'), -3]
            else
                return [temp_ver.to_i.to_s, -2]
            end
        end

        [temp_ver, -2]
    end

    def clear_slashes!( str )
        str.gsub! %r{/+}, '/' # remove slashes
        str.sub! ":/", "://"  # workaround fix #1
    end
end

class MirrorListProceedPath < MirrorListProceed

    def initialize( path, country = nil )
        @path = path
        @country = country
        @mlist = []

        init_mlist
        generate_main_list
    end

private

    def generate_main_list
        get_mirrors_array.each do |mirror_db|
            mirror = mirror_db.url
            path = @path
            path = path[1..-1] if path[0] == '/'
            str_to_add = URI.join( URI(mirror), path ).to_s
            str_to_add += '/' if str_to_add[-1] != '/'
            @mlist << str_to_add
        end
    end

    def init_mlist
        init_str = "# path = #{@path}"
        init_str += add_countries_to_mlist
        @mlist << init_str
    end
end
