require "application_responder"

class ApplicationController < ActionController::Base
  # include Pundit

  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert:exception.message
  end

  skip_authorization_check
end
