# Bill Tracker

## Introduction
This application is for helping you keep track of your bills. You configure payees, payment schedules, and can keep track of upcoming or past payments. This application will not actually make payments for you, but it's helpful as a sort of ledger.

## Tools Used

* Ruby 2.6.3
* Rails 6
* Bootstrap 4
* ECMAScript with Babel
* Rspec 3.8
* SQLite 3
* Whenever

Check out the Gemfile or package.json for additional dependencies if you're interested.

## Deployment
Deployment is done via Capistrano. Configure config/deploy.rb:
    # cap production deploy
    
## Docker
Docker build scripts are provided in the docker folder. The app runs on port 80 in the container.

## Test Suite
Testing is done using rspec and capybara for system/integration tests. The rake test is overridden to also run
various static analyzers (rubocop, rails-best-practices, brakeman, etc.)

    # rake test

