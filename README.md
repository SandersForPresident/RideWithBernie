### The Mission

We want to build an app to help people get rides. We're going to start by helping people get to events, like volunteering opportunities,
and work our way up to helping people get to the polls on caucus day and election day.

### Requirements

1. Ruby 2.3.0
2. Rails 4.2.5
2. [RubyGems](https://rubygems.org/pages/download)
3. [Bundler](http://bundler.io/)
3. Postgres ([Postgres.app](http://postgresapp.com/) recommended for OS X).

If you want to modify the front-end assets, you'll also need:

1. Node (`brew install node` if you don't have it)
2. Bower (`npm install -g bower` if you don't have it)

### Installing

1. Clone this repo with `git clone git@github.com:SandersForPresident/RideWithBernie.git`
2. `cd RideWithBernie`
2. `bundle install`
4. Create the database with `bin/rake db:create`.
5. Boot up the server with `rails server`
5. Head to [http://localhost:3000](http://localhost:3000).


### Startup Guide for getting setup on a Codeanywhere VM

[https://gist.github.com/cmuld3r/2071d5df7ce7717d2c68](https://gist.github.com/cmuld3r/2071d5df7ce7717d2c68)


### What our app is setup with

- Rails 4.2.5
- Ruby 2.3.0
- Angular 1.4.7
- [BernieStrap](http://coders.forsanders.com/bootstrap/)
- [Font Awesome](http://fontawesome.io/get-started/) icons
- Ruby/Angular/Bower setup done as in [this blog](http://angular-rails.com/index.html).

### Where is everything?

The main html file is `app/views/pages/index.html.erb`, which is rendered inside the layout `app/views/layouts/application.html.erb`.
This file just boots up the angular app, and hosts the ng-view.

**Templates** are stored in `app/assets/javascripts/templates`, and end with `.html` or `.html.erb`.

**Coffeescript** is all in `app/assets/javascripts/app.coffee`, let's just keep ourselves to one coffee file for now.

There's no API yet, but when we've got one, we'll post it here!

### Getting new front-end libraries

We're using [bower-rails](https://github.com/rharriso/bower-rails/) for super simple front-end asset management,
and all assets are stored in `vendor/assets/bower_components`. If you need more front-end libraries, modify the `Bowerfile`, and then install them with `rake bower:install`. You may need to google around to find the exact line to put into the `Bowerfile`.

### Deploying

The app is currently set up to auto-deploy through Heroku, but there is one manual step involved (so we don't accidentally break anything). Anytime a commit is made on the `master` branch of *this repository*, [SandersForPresident/RideWithBernie](https://github.com/SandersForPresident/RideWithBernie/), that code is automatically deployed out to our staging app, called `ridewithbernie-staging` on Heroku, which lives at https://staging.ridewithbernie.com. We can then test it out, and make sure everything is working properly. If it is, then any Heroku collaborator can head to our "Pipeline" [here](https://dashboard.heroku.com/pipelines/45a6121c-3cf8-4c23-8c0b-7fac2a4be3cf) to "Promote" the code from staging to production. The production app, called `ridewithbernie` on Heroku, lives at https://ridewithbernie.com.

Note: It's possible that the auto-deploy will fail, causing the staging app to seem un-updated, in which case errors will show up on the Heroku Pipeline.

### Contributing

We use the [Github Flow](https://guides.github.com/introduction/flow/) branching model.
Make sure to create new, well-named branches for all work, and then submit PRs back to master when you are ready to merge your changes.
No pushing straight to master!

We have our own Slack team, so if you want to get onto that, email [buddhistsforbernie@gmail.com](mailto:buddhistsforbernie@gmail.com) and he'll invite you.

You can find our todo list in [Issues](https://github.com/kyletns/RideWithBernie/issues)!
