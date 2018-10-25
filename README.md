# LuckyParam

[![Build Status](https://travis-ci.org/shootingfly/lucky_param.svg?branch=master)](https://travis-ci.org/shootingfly/lucky_param)

A simple parameter validation in controller for Rails.

Compare to `apipie`, `grape`, it is neccessary to check param in controller.

## Usage

```rb
gem "lucky_param"
```

### Define any validator for your app:
app/controllers/application_controller.rb

```rb
class SessionControllers < ApplicationController
  include LuckyParam

  LuckyParam::CUSTOM_CHECKER = {
    Email: [
      ->(obj) { obj =~ /([0-9a-zA-Z]){6,30}/ },
      "must be valid email"
    ],
    Password: [
      ->(obj) { obj =~ /([0-9a-zA-Z]){6,30}/ },
      "must be valid password"
    ],
  }.freeze
end
```

app/controllers/sessions_controller.rb

```rb
class SessionControllers < ApplicationController
  def create
    required :email, :Email
    required :password, :Password
    render json: 'ok'
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
