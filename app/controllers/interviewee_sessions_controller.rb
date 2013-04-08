class IntervieweeSessionsController < ApplicationController
	def create
		@interviewee_session = IntervieweeSession.new
		@interviewee_session.random = params[:random]
		session[:viewee_random] = @interviewee_session.random
		if @interviewee_session.save
			redirect_to('/interview/'+session[:viewee_random])
		else
			params[:random] = nil
			session[:viewee_random] = nil
      		redirect_to(new_session_path)
		end

	end

	def show
		@interviewee_session = IntervieweeSession.find_by_random(session[:viewee_random])
	end

	def destroy
		@interviewee_session = IntervieweeSession.find_by_random(session[:viewee_random])
		session[:viewee_random] = nil
		@interviewee_session.destroy
		redirect_to(new_session_path)
	end
end
