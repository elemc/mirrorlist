# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

arches = Arch.create(
    [   { name: 'i386' },
        { name: 'x86_64' },
    ]
)

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
