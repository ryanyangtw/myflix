# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Video.create(title: "Futurama", description: "A show about the future!", small_cover_url: '/public/tmp/futurama.jpg', large_cover_url: '/tmp/futurama.jpg' )
Video.create(title: "Monk", description: "Not sure what this show is about.", small_cover_url: '/public/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')
Video.create(title: "Family Guy", description: "Family Guy is an American adult animated sitcom created by Seth MacFarlane", small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/family_guy.jpg')