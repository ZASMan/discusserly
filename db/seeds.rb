# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Seed Users
admin_user = User.create!(name: "Admin User", email: 'admin@test.com', password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: true, activated: true, activated_at: Time.zone.now)

regular_user = User.create!(name: "Test User", email: 'test@test.com', password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: false, activated: true, activated_at: Time.zone.now)

regular_user1 = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: false, activated: true, activated_at: Time.zone.now)

#Seed Posts

5.times do |n|
	title = Faker::Company.catch_phrase
	content = Faker::Hipster.paragraph(2, true, 4)
	admin_user.posts.create!(title: title,
										content: content)
end

5.times do |n|
	title = Faker::StarWars.quote
	content = Faker::Lorem.paragraphs(1)
	regular_user.posts.create!(title: title,
														content: content)
end

5.times do |n|
	title = Faker::Hacker.say_something_smart
	content = Faker::Lorem.paragraph(2, false, 4)
	regular_user1.posts.create!(title: title,
														content: content)
end

#Seed Profiles

location = Faker::Address.city.capitalize + ", " + Faker::Address.country.capitalize
occupation = Faker::Company.profession.capitalize
about_me = Faker::Hipster.paragraph
image_url = Faker::Avatar.image("my-own-slug", "50x50", "bmp", "set1", "bg1")

admin_user_profile = admin_user.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)

regular_user_profile = regular_user.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)

regular_user1_profile = regular_user1.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)

