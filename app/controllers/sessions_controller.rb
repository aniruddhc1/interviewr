class SessionsController < ApplicationController
	def new
		if interviewer?
			redirect_to('/interviewee', :alert => 'You still have a session going on.')
		end
		if interviewee?
			redirect_to('/interviewee', :alert => 'You are already participating in an interview.')
		end
		@session = Session.new
	end
	def create
		if (session[:viewee_random] != nil)
			redirect_to('/interviewee', :alert => 'You are already participating in an interview.')
			return
		end

		@session = Session.new(params[:session])
		@session.random = generate_id
		if (Session.find_by_random(@session.random) != nil)
			@session.random = generate_id
		end
		session[:random] = @session.random
		config_opentok

		@new_room = Room.new
		location = "http://interviewr.us/"
		session_properties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "enabled"}
		session = @opentok.create_session(location, session_properties)
		@new_room.openTokID = session.session_id
		@new_room.name = @session.random
		@session.save
		@new_room.session_id = @session.id
		@new_room.save
		redirect_to('/interviewer', :notice => 'The URL is interviewr.us/' + @session.random)
	end

	def show
		@session = Session.find_by_random(session[:random])
		config_opentok
		@token = @opentok.generate_token :session_id => @session.room.openTokID
	end 

	def destroy
		@session = Session.find_by_random(session[:random])
		session[:random] = nil
		@session.destroy
		redirect_to('/', :notice => 'The interview has ended.  Start another?')
	end

	private
	def generate_id
		a = (0...36).map{|i|i.to_s 36}
		s = ''
		(0...(rand(10)+15)).each do |i|
			s += a[rand(36)]
		end
		return s
	end

end
