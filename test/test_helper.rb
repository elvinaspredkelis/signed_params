require "rails"
require "rails/application"
require "action_controller"
require "action_controller/test_case"

require "signed_params"

class SignedParams::Application < Rails::Application
end

SignedParams::Railtie.run_initializers :default, Rails.application

Rails.logger = Logger.new "/dev/null"

class PostsController < ActionController::Base
  def show
    render plain: params.signed[:id]
  end
end

Rails.application.routes.draw do
  resources :posts
end

class ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  setup { @app = Rails.application }
end
