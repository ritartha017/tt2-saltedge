# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  APP_ID = ENV['APP_ID']
  SECRET = ENV['SECRET']
end
