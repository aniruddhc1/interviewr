class IntervieweeSessionsController < ApplicationController
	def new
		@random = params[:random]
		@session = Session.find_by_random(@random)
		if (@session == nil)
			flash[:alert] = "You have tried to connect to an interview that doesn't exist. Create a new one?"
			redirect_to('/')
		end
		@interviewee_session = IntervieweeSession.new
	end

	def destroy
		@interviewee_session = IntervieweeSession.find_by_random(session[:viewee_random])
		@session = Session.find_by_random(session[:viewee_random])
		@interviewee_session.destroy if @interviewee_session != nil
		session[:viewee_random] = nil
	end

	def create
		if (session[:random] != nil)
			flash[:alert] = "You are already hosting an interview."
			redirect_to('/interviewer')
			return
		end

		@interviewee_session = IntervieweeSession.new(params[:interviewee_session])
		random = @interviewee_session.random

		if @interviewee_session.save
			session[:viewee_random] = random
			r = Room.find_by_name(@interviewee_session.random)
			r.interviewee_session_id = @interviewee_session.id
			r.save
			redirect_to('/interviewee')
		else
			destroy
			if (Session.find_by_random(random) == nil)
				flash[:alert] = "You have tried to connect to an interview that doesn't exist. Create a new one?"
				redirect_to('/')
			else
				flash[:alert] = "You have tried to connect to an interview someone already connected to. Create a new one?"
      			redirect_to('/')
      		end
		end

	end

	def show
		if (Session.find_by_random(session[:viewee_random]) == nil)
			destroy
			redirect_to('/disconnected')
		else
			config_opentok
			@interviewee_session = IntervieweeSession.find_by_random(session[:viewee_random])
			@token = @opentok.generate_token :session_id => @interviewee_session.room.openTokID
		end
	end
end
