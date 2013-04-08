class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_session
    @current_session ||= Session.find_by_random(session[:random]) if session[:random]
  end
  helper_method :current_session

  def in_progress?
    current_session
  end
  helper_method :in_progress?
end
