class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_viewer_session
    @current_viewer_session ||= Session.find_by_random(session[:random]) if session[:random]
  end
  helper_method :current_viewer_session

  def current_viewee_session
    @current_viewee_session ||= Session.find_by_random(session[:viewee_random]) if session[:viewee_random]
  end
  helper_method :current_viewee_session

  def interviewer?
    current_viewer_session
  end
  helper_method :interviewer?

  def interviewee?
    current_viewee_session
  end
  helper_method :interviewee?

  def interviewer_name
    @interviewer_name ||= Session.find_by_random(session[:viewee_random]).interviewer if session[:viewee_random]
  end
  helper_method :interviewer_name

  def interviewer_co
    @interviewer_co ||= Session.find_by_random(session[:viewee_random]).company if session[:viewee_random]
  end
  helper_method :interviewer_co
end
