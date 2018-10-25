# PanDomain

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pan_domain'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pan_domain

## How to use

1. Install all domains

        $ pan_domain install

    or with rake command

        $ rake pan_domain:install

2. Generate all migrations from all domains

        $ pan_domain generate_migrations

    or with rake command
    
        $ rake pan_domain:install:migrations
        
3. Seed all data from all domains

        $ pan_domain generate_seeds

    or with rake command

        $ rake pan_domain:db:seed

4. Install a specific domain (require add ```gem 'pan_domain'``` in the Gemfile)

        $ rake [domain_name]_domain:install (eg: rake human_domain:install)

5. Generate all migrations from a specific domain (require add ```gem 'pan_domain'``` in the Gemfile)

        $ rake [domain_name]_domain:generate:migrations (eg: rake human_domain:generate:migrations)

6. Loads all seed data from a specific domain (require add ```gem 'pan_domain'``` in the Gemfile)

        $ rake [domain_name]_domain:db:seed (eg: rake human_domain:db:seed)

7. List available commands
        $ pan_domain --help

## Test

To run all tests, you can use this command in root directory:

    $ rake spec

Note: run `rspec` in root directory will not working.

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
