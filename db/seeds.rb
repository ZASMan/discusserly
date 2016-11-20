# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Seed Users
admin_user = User.create(name: "Admin User", email: 'admin@test.com', password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: true, activated: true, activated_at: Time.zone.now)

regular_user = User.create(name: "Test User", email: 'test@test.com', password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: false, activated: true, activated_at: Time.zone.now)

banned_user = User.create(name: "Banned User", email: 'banned@test.com', password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: false, activated: true, activated_at: Time.zone.now, banned: true)


80.times do |n|
	name = Faker::Name.name
	email = Faker::Internet.email
	password = "Foobar1!1"
	User.create!(name: name,
							email: email,
							password: password,
							password_confirmation: password,
							activated: true,
							activated_at: Time.zone.now)
end


20.times do |n|
	name = Faker::StarWars.character
	email = Faker::Internet.email
	password = "Foobar1!1"
	User.create!(name: name,
							email: email,
							password: password,
							password_confirmation: password,
							activated: true,
							activated_at: Time.zone.now)
end

#Seed Posts

20.times do |n|
	title = Faker::Company.catch_phrase
	content = Faker::Hipster.paragraph(2, true, 4)
	admin_user.posts.create!(title: title,
										content: content)
end

10.times do |n|
	title = Faker::StarWars.quote
	content = Faker::Lorem.paragraphs(1)
	regular_user.posts.create!(title: title,
														content: content)
end

10.times do |n|
	title = Faker::Hacker.say_something_smart
	content = Faker::Lorem.paragraph(2, false, 4)
	regular_user.posts.create!(title: title,
														content: content)
end

