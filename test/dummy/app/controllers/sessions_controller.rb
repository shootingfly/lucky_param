# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    required :email, :Email
    required :password, :password
    render json: {
      code: "200",
      msg: "ok",
      data: {
        token: params[:email].to_s
      }
    }
  end
end
