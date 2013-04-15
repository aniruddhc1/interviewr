class IntervieweeSessionsController < ApplicationController
	def destroy
		@interviewee_session = IntervieweeSession.find_by_random(session[:viewee_random])
		@interviewee_session.destroy if @interviewee_session != nil
		session[:viewee_random] = nil
	end

	def create
		if (session.has_key?(:viewee_random))
			isession = IntervieweeSession.find_by_random(session[:viewee_random])
			isession.destroy if (isession != nil)
			session[:viewee_random] = nil
		end
		if (session.has_key?(:random))
			osession = Session.find_by_random(session[:random])
			osession.destroy if (session != nil)
			session[:random] = nil
		end


		random = params[:random]
		@interviewee_session = IntervieweeSession.new
		@interviewee_session.random = random

		if @interviewee_session.save
			session[:viewee_random] = random
			r = Room.find_by_name(@interviewee_session.random)
			r.interviewee_session_id = @interviewee_session.id
			r.save
			redirect_to('/interviewee')
		else
			if (Session.find_by_random(random) == nil)
				redirect_to('/no_session')
			else
      			redirect_to('/busy')
      		end
		end

	end

	def show
		if (Session.find_by_random(session[:viewee_random]) == nil)
			IntervieweeSession.find_by_random(session[:viewee_random]).destroy
			redirect_to('/disconnected')
		else
			config_opentok
			@interviewee_session = IntervieweeSession.find_by_random(session[:viewee_random])
			@token = @opentok.generate_token :session_id => @interviewee_session.room.openTokID
		end
	end
end
