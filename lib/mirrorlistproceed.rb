#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-
# -*-      Ruby     -*-
# ------------------------------------ #
# Ruby source class (Object)           #
# Author: Alexei Panov <me@elemc.name> #
# ------------------------------------ #
# Description: 


class MirrorListProceed < Object
    def initialize( repo, arch )
        @repo = repo
        @arch = arch
        @mlist = []

        init_mlist

        # arches
        return unless Arch.all.include? @arch

        # workarounds
        wa = Workaround.all
        workaround = wa.find_by key: @repo

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
    end

    def to_s
        @mlist.join( '\n' )
    end

    private

    def init_repo
        repo_split = @repo.split '-'
        return nil if repo_split.size == 0

        # Repository type
        repo_type = repo_split[0]
        return nil unless RepositoryType.all.include? repo_type

        # Version
        version,next_pos = get_version_from_repo( repo_split )

        # repo
        repo = repo_split[1..nextpos].join( '-' )

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

        version_record = Release.find_by name: version
        return nil if version_record.nil?
        variant = 'development' unless version_record.stable
        
        #TODO: I've finished here
    end

    def get_me_varian_and_portion( repo )
        match5 = test_and_get_regexp ( /.*fedora-updates-(.*)-(.*)/, repo ) 
        unless match5.nil?
            return generate_updates_vp match5[1], match5[2]
        end

        match4 = test_and_get_regexp ( /.*fedora-updates-(.*)/, repo )
        unless match4.nil?
            return generate_updates_vp match5[1]
        end

        match3 = test_and_get_regexp ( /.*fedora-(.*)/, repo )
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
        portion = match5[2]
        return [variant, portion]
    end

    def test_and_get_regexp( regexp, repo )
        m = regexp.match repo
        return nil if m.nil?

        m[1]
    end

    def init_mlist
        init_str = "# repo = #{@repo} arch = #{@arch}"
        Language.all.each { |lang| init_str += " country = #{lang.name}" }
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

        temp_ver
    end
end

