# README

# Discusserly
Discusserly is a discussion forum/social media site written with the Ruby on Rails Framework, rapidly developed in my spare time in November 2016.

Live Link: http://discusserly.herokuapp.com

My biggest problem as a developer is not finishing projects, so I was determined to work on this and have a decent portfolio project to show off my current knowledge, and be proud of myself.

The primary goal with this project was to do implement as many features as possible from 'scratch' to assure that I better understood the 'science' behind it with less 'rails magic' and gems. In addition, I wanted to learn test driven development.

User Model, Authentication, and Authorization
* Model + Data Validation: The app follows the "fat models skinny controller" method and validates most of the data directly in the model (regex's for email format, presence for fields, etc.) 
* Authentication: I had only used the devise gem for authentication in the past, so this time I utilized RailsCast videos and Michael Hartl's Rails Tutorial to learn the 'science' behind creating an authentication from 'scratch' (Bcrypt gem for has secure password and password digest, how rails 'session' for login works, etc.
* Authorization: I implemented my own custom before filters in each controller (I.E. users shouldn't be able to view the edit page of a post that doesn't belong to them, banned users are only allowed to view a 'forbidden' page on the site, etc.)

Profile Model
* Upon registration, users will have an associated profile built for them with default values that they can edit themselves. That way, the users won't have to 'create a new profile' on registration and leave us worrying about adding logic in a view for creating a new profile if they don't have one etc. and close a bag of worms.  Originally I planned on adding custom REST actions to the user model to have a seperate view for editing "account settings" fields (E.G. email/password) and "profile" fields (E.G. about me) but that seemed messy.
* Profanity Filter Included on Profile.

Posts Model
* Implemented a custom profanity check method on before save with a list of profane words stored in a global variable in a module (if anyone has a better suggestion on how to implement this, please let me know). Profane words will come out as "filtered." Any other suggestions would be helfpul as well.

Comments Model
* Polymorphic Association, comments are associated with posts and profiles.
* Profanity filter also included on this.

Tests
* Minitest was used as the testing framework
* Before implenting each feature, I would create a test with my expectations, write out the code for the features with how I think they should work, and run the tests and refactor. This was 100x better than my previous untested projects and has helped me become a much more effective developer
* This test driven development philosophy made me develop my app much more efficiently, but I would still manually log into my app and test features if I hit a wall, simply because visualization always helps.

Coming Soon (As of 11/30/16)
* Friending or following users
* Uploading own profile images
* Overall better and more attractive UI, basically just boostrapped for now since it was more of a back end project at first.
* Some kind of fancy client side action.
* More test cases. A few unsolved failures at the moment which I haven't figured out.

Any suggestions on how I can improve this app are welcome! Submit a pull request or issue!
