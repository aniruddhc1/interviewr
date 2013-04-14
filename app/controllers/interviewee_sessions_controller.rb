class IntervieweeSessionsController < ApplicationController
	def destroy
		@interviewee_session = IntervieweeSession.find_by_random(cookies[:viewee_random])
		@interviewee_session.destroy if @interviewee_session != nil
		cookies[:viewee_random] = nil
	end

	def create
		if (cookies[:random] != nil)
			redirect_to('/interviewer', :notice => 'You are already hosting an interview.')
			return
		end

		random = params[:random]
		@interviewee_session = IntervieweeSession.new
		@interviewee_session.random = random

		if @interviewee_session.save
			r = Room.find_by_name(@interviewee_session.random)
			r.interviewee_session_id = @interviewee_session.id
			r.save

			cookies[:viewee_random] = random
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
		if (Session.find_by_random(cookies[:viewee_random]) == nil)
			destroy
			redirect_to('/disconnected')
		else
			config_opentok
			@interviewee_session = IntervieweeSession.find_by_random(cookies[:viewee_random])
			@token = @opentok.generate_token :session_id => @interviewee_session.room.openTokID
		end
	end
end
