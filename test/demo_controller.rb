# frozen_string_literal: true

require "lucky_param"

class DemoController
  include LuckyParam
  LuckyParam::CUSTOM_CHECKER = {
    Password: [
      ->(params, column) { params[column] =~ /([1-9a-zA-Z]){6,21}/ },
      "must be valid password"
    ]
  }.freeze
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def create
    required(:username, :String)
    optional(:password, :Password)
    params[:username]
  end
end
