# Software Engineering Challenge

## Project Description

Imagine LivingSocial has just acquired a new company.  Unfortunately, the company has never stored their data in a database and instead uses a plain text file.  This application provides a way for the new subsidiary to import their data into a database.

1. This application accepts (via a form) a tab delimited file with the following columns: purchaser name, item description, item price, purchase count, merchant address, and merchant name.
1. It then parses the given file, normalizes the data, and stores the information in a relational database.
1. After the import is complete, the application displays the total amount of gross revenue represented by the uploaded file.

### Installation

* Clone the repo

  `git clone git@github.com:randomutterings/data-engineering.git -b first-pass`

* Create the database

  `cd data-engineering && rake db:migrate`

* Start the webserver

  `rails s`

* Access the app

  http://localhost:3000

### Configure Twitter OAuth (optional)

* Visit https://apps.twitter.com and create a new application. Then click on Test OAuth to get the consumer key and secret. Don’t confuse these values with the access token and secret as the're for something different.

* This application looks for the key and secret in environment variables.  Specify them like this `TWITTER_KEY=my_twitter_key TWITTER_SECRET=my_twitter_secret rails s`

### Running Tests

  `rake spec`

Tested with Ruby 1.9.3 and 2.1.0
