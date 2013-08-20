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
    end

    def to_s
        "repo:#{@repo}/arch:#{@arch}/in #{Rails.root}"
    end
end

