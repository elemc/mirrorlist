# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#require 'net/http'

arches = Arch.create(
    [   { name: 'i386' },
        { name: 'x86_64' },
    ]
)

lagnuages = Language.create(
    [   { name: 'RU' },
        { name: 'EN' },
    ]
)

types = RepositoryType.create(
    [   { rtype: 'free', path_part: '/free/fedora/' },
        { rtype: 'nonfree', path_part: '/nonfree/fedora/' },
        { rtype: 'fixes', path_part: '/fixes/fedora/' },
    ]
)

releases = Release.create( [{ name: 'rawhide', stable: false }] )

# System !!!
variants = RepositoryVariant.create(
    [   { name: 'main', url: '$mirror$/russianfedora/$repos$/releases/$version$/Everything/$arch$/$portion$/' },
        { name: 'updates', url: '$mirror$/russianfedora/$repos$/updates/$version$/$arch$/$portion$/' },
        { name: 'updates-tesing', url: '$mirror$/russianfedora/$repos$/updates/testing/$version$/$arch$/$portion$/' },
        { name: 'development', url: '$mirror$/russianfedora/$repos$/development/$version$/$arch$/$portion$/' },
        { name: 'build', url: '$mirror$/build/$version$/$portion$/$arch$/' },
        { name: 'build-development', url: '$mirror$/build/development/$version$/$portion$/$arch$/' },
    ]
)
porions = RepositoryPortion.create(
    [
        { name: 'development', url_part: '/os/' },
        { name: 'main', url_part: '/os/' },
        { name: 'debug', url_part: '/debug/' },
        { name: 'source', url_part: '/SRPMS/' },
    ]
)

# Fill countries
require 'net/http'
countries_url = URI 'http://www.iso.org/iso/home/standards/country_codes/country_names_and_code_elements_txt.htm'
content = Net::HTTP.start(countries_url.host) do |http|
    resp = http.get(countries_url.path)
    resp.body
end
clist = content.force_encoding('utf-8').split "\r\n"
clist[1..-1].each do |cpair|
    name,code = cpair.split ';'
    match = Country.find_by_code code
    next unless match.nil?
    Country.new do |c|
        c.code = code
        c.name = name
        c.save
    end
end

# Fill admin
admin = User.create( [{ email: 'admin@localhost.tld', password: '1234', password_confirmation: '1234', role: 'admin'}] )
