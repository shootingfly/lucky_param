# frozen_string_literal: true

class ApplicationController < ActionController::API
  include LuckyParam
  LuckyParam::CUSTOM_CHECKER = {
    password: [
      ->(obj) { obj =~ /([0-9a-zA-Z]){6,30}/ },
      "must be valid password"
    ]
  }.freeze

  rescue_from ParamMissError, ParamFormatError do |err|
    render json: {
      code: "422",
      msg: err
    }
  end
end
