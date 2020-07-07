# LuckyParam

[![Build Status](https://travis-ci.org/shootingfly/lucky_param.svg?branch=master)](https://travis-ci.org/shootingfly/lucky_param)

A simple parameter checker in controller for Rails Api.

### Do Check, Fail Fast

## Usage

Gemfile
```rb
gem "lucky_param"
```

app/controllers/application_controller.rb

```rb
class ApplicationController
  include LuckyParam

  # If necessary, you can overide or define your own parameter checkers.
  LuckyParam::CUSTOM_CHECKER = {
    Password: [
      ->(params, column) { params[column] =~ /([0-9a-zA-Z]){6,30}/ },
      "must be valid password"
    ],
  }.freeze
end
```

app/controllers/sessions_controller.rb

```rb
class SessionsController < ApplicationController
  def create
    required :email, :Email
    required :password, :Password
    optional :nick_name, :String
    render json: 'ok'
  end
end
```

## Internal Checkers

[Checkers](https://github.com/shootingfly/lucky_param/blob/master/lib/lucky_param/checker.rb)

## Contributing

1. Fork it ( https://github.com/shootingfly/lucky_param/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Make your changes
4. Run `ruby test/lucky_param_test.rb` to run the tests
5. Commit your changes (git commit -am 'Add some feature')
6. Push to the branch (git push origin my-new-feature)
7. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
