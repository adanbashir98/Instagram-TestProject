# InstagramClone-TestProject
This Test Project was created by me during my training in DevSinc. It was implemented using RoR.

# Prerequisites
* Things to consider:
        Configurations of tools used.
# InstagramClone-RailsTestProject
Ruby Version:
* Version : 2.7

System Dependencies
* Rails 5.2
* Postgresql 14

Gems
* ransack
* cloudinary
* bootstrap
* font-awesome
* devise

Configurations:
1. Clone the code from github before starting.
2. Make sure to install the system dependencies before starting of above mentioned versions.

Steps to follow:
1. Install RVM.
2. Install ruby and rails dependencies.
  Use the following commands to install the dependencies:
    curl -L get.rvm.io | bash -s stable
    sudo apt-get install build-essential openssl libreadline6-dev
    rvm install 2.7
    gem install bundler
    gem install bundler -v 1.17
    gem install rails
3. Install Postgresql and set up a user profile. Add the user credentials.
4. Cloudinary credentials must also be set in the credentials.
5. Set up the database by using rails db:setup.
6. Install all the gems required using the command: bundle install

Deployment instructions:
1. Enable automatic deployment on Heroku for easy deployment after pushing all your finalised code on github.
2. After deployement, go to Heroku console and run the following commands in order:
  rails db:setup
  rails db:migrate
  rails db:seed

To test models:
1. Run rails c in console, to test the models and associations.

To start the rails server:
1. Run rails s.

* Rails Server: http://localhost:3000/

* Application live at https://instagram-testproject.herokuapp.com/
