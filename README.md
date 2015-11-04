**Update:** If you're just getting here and interested in helping, please do 2 things:

1. Glance through this Readme so you have an idea of what the project is about
2. [Fill out a row for yourself on this introduction spreadsheet](https://docs.google.com/spreadsheets/d/15B-g3MRpAffFGhvdjjrrCutL304OMWZMSekVZ_lWqI8/edit#gid=0) (so we can pick what tech to use)

**Note about Slack**: We have our own Slack team, so please either add your email to the spreadsheet above (you can remove it once you've been invited), or just email BuddhistsForBernie at [buddhistsforbernie@gmail.com](mailto:buddhistsforbernie@gmail.com) and he'll invite you.

---

### Installing

1. Clone this repo
2. `bundle`
3. Install postgres onto your system ([Postgres.app](http://postgresapp.com/) recommended for OS X).
4. Create a postgres database with `bin/rake db:create`.
5. Head to `localhost:3000`
6. Make sure you've got node installed with `node -v` (`brew install node` if you don't have it).
6. Make sure you've got bower installed with `bower -v` (`npm install -g bower` if you don't have it).

### What our app is setup with

- Rails 4.2.4
- Ruby 2.2.3
- Angular 1.4.7
- [BernieStrap](http://coders.forsanders.com/bootstrap/)
- [Font Awesome](http://fontawesome.io/get-started/) icons
- Ruby/Angular/Bower setup done as in [this blog](http://angular-rails.com/index.html).

### Where is everything?

The main html file is `app/views/pages/index.html.erb`, which is rendered inside the layout `app/views/layouts/application.html.erb`.
This file just boots up the angular app, and hosts the ng-view.

**Templates** are stored in `app/assets/javascripts/templates`, and end with `.html` or `.html.erb`. I've put 2 in there for starters.

**Coffeescript** is all in `app/assets/javascripts/app.coffee`, let's just keep ourselves to one coffee file for now.

There's no API yet, but when we've got one, we'll post it here!

### Getting new front-end assets

We're using [bower-rails](https://github.com/rharriso/bower-rails/) for super simple front-end asset management,
and all assets are stored in `vendor/assets/bower_components`. If you modify the `Bowerfile` and you need to pull down extra front-end
assets, just use `rake bower:install`.

### TODO

All managed through [Issues](https://github.com/kyletns/RideWithBernie/issues)!

