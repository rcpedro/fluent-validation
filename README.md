# Fluent::Validation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-validation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-validation

## Usage

Include `Fluent::Validation` to your models:

```ruby
class User
  include ActiveModel::Model
  include Fluent::Validation
end
```

And add validations in groups for mandatory properties and optional properties:

```ruby
class User
  include ActiveModel::Model
  include Fluent::Validation

  mandatories :first_name, 
              :last_name, 
              :username,
              { email:      { format: { with: URI::MailTo::EMAIL_REGEXP }}},
              { contact_no: { numericality: true, format: { with: /\d+/ }}}

  optionals gender: { inclusion: { in: ['M', 'F'] }}
end
```

The above would be the equivalent of:

```ruby
class User
  include ActiveModel::Model
  include Fluent::Validation

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :username,   presence: true
  validates :email,      presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :contact_no, presence: true, numericality: true, format: { with: /\d+/ }

  validates :gender, inclusion: { in: ['M', 'F'] }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fluent-validation.

