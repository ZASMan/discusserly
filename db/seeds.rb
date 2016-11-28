#Seed Users
admin_user = User.create!(name: "Admin User", email: 'admin@test.com', password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: true, activated: true, activated_at: Time.zone.now)

regular_user = User.create!(name: "Test User", email: 'test@test.com', password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: false, activated: true, activated_at: Time.zone.now)

regular_user1 = User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: 'Foobar1!', password_confirmation: 'Foobar1!', admin: false, activated: true, activated_at: Time.zone.now)

#Seed Posts
post1 = admin_user.posts.create!(title: "Renowned Billionaire Bruce Wayne Passes Away at Age of 56", content: "Mr. Wayne passed away at his home in Wayne Manor in Gotham City this past Sunday")

post2 = regular_user.posts.create!(title: "Mars rover recovers evidence of microscopic life", content: "The most recent Mars Rover trip has discovered evidence of 500 million year old microscopic organisms resembling bacteria.")
#Seed Post Comments
post1_comment = post1.comments.build(body: Faker::Hipster.sentence, user_id: regular_user.id)
post1_comment2 = post1.comments.build(body: "Wow, this is so sad :/", user_id: regular_user1.id)
post2_comment = post2.comments.build(body: Faker::Hipster.sentence(3), user_id: regular_user.id)

#Seed Profiles
#Locations
location = Faker::Address.city.capitalize + ", " + Faker::Address.country.capitalize
location2 = Faker::Address.city.capitalize + ", " + Faker::Address.country.capitalize
location3 = Faker::Address.city.capitalize + ", " + Faker::Address.country.capitalize
#Occupations
occupation = Faker::Company.profession.capitalize
occupation2 = Faker::Company.profession.capitalize
occupation3 = Faker::Company.profession.capitalize
#About_me
about_me = Faker::Hipster.paragraph
about_me2 = Faker::Hipster.paragraph
about_me3 = Faker::Hipster.paragraph
#Images
image_url = Faker::Avatar.image("my-own-slug", "50x50", "bmp", "set1", "bg1")
image_url2 = Faker::Avatar.image
image_url3 = Faker::Avatar.image("my-own-slug")

admin_user_profile = admin_user.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)

regular_user_profile = regular_user.create_profile(location: location2, occupation: occupation2, about_me: about_me2, image_url: image_url2)

regular_user1_profile = regular_user1.create_profile(location: location3, occupation: occupation3, about_me: about_me3, image_url: image_url3)


