#Zendesk Help Form in Rails#

This Rails application is a simple form that creates a new ticket with a new requester. On form submission success, it will create a ticket in the Zendesk backend. When that user logs into their account, they will be able to view all the tickets they've submitted and make comments. This uses the devise gem to handle user authentication. If you'd like to read up on that check that out here: <https://github.com/plataformatec/devise>

__First clone the repository:__

```
git clone git@github.com:devarispbrown/zendesk_help_rails.git
```
__Then run bundle install:__

```
bundle install
```

To get this to run locally make sure you set environment variables for ZD_URL, ZD_USER, ZD_PASS.

__Setting Environment Variables On Mac__

```
export ZD_URL='https://example.zendesk.com/api/v2'
export ZD_USER='user@example.com'
export ZD_PASS='password'
```

__Setting Environment Variables On Windows__

```
set ZD_URL='https://example.zendesk.com/api/v2'
set ZD_USER=user@example.com
set ZD_PASS=password
```

This example also uses an external DB to pull in game information to populate a custom field for logged in users. This field could be anything, but you need to change the field id in the code so it gets properly submitted with the ticket request. Create a database.yml file in the app/config folder with your database settings and load the schema.

__Example database.yml__

```
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: postgresql
  database: zendesk_help_rails
  host: localhost
```

__Create database and load schema__

```
rake db:create
rake db:schema:load
```

In tickets_controller.rb change the following line to match your custom field id:

```
if @game_name
  options[:custom_fields] = {:id => "21833683", :value => @game_name}
```

Once all this is set you should be able to run the rails server and use the sample application locally.

If you have any questions on setup or the code please email <api@zendesk.com> and we'll try to help troubleshoot. Hope this helps!
