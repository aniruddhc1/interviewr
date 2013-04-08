class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_session
    @current_session ||= @session
  end
  helper_method :current_session

  def in_progress?
    current_session
  end
  helper_method :in_progress?
end
