# Grand Viz Auto

Features

+ Download the data
+ Submit entries
+ Rate submissions (via Raty)
+ OAuth-only login (Github, Facebook, Twitter, Google)


## Set up the development environment

Clone the repository.

`git clone git@github.com:MAPC/grandvizauto.git`

CD into the repository

`cd grandvizauto`

If you have RVM, create a new gemset.

`rvm gemset use grandvizauto --create`

Install the gems

`bundle install`

Set up the database

```sh
rake db:setup
rake db:migrate
rake db:seed    # loads sample data into the database
rake db:test:prepare
```

If you want, run the tests to make sure everything is working.

`rspec`


To get the site running, run `rails server` or `rails s` for short



## Getting access to everything

While the server is running, log in using your Github, Facebook, Twitter, or Google Accounts.

Quit the server once you've logged in, using `Control+C` aka `^C`.

Start the Rails console: `rails c`.

Make yourself an admin user by running:

```ruby
  User.last.update_attribute(:admin, true)
```

Quit the console by entering `quit`, then start the server back up to run the site (`rails s`).
