class SessionsController < ApplicationController
	def new
		@session = Session.new
	end
	def create
		if (cookies[:viewee_random] != nil)
			redirect_to('/interviewee', :notice => 'You are already participating in an interview.')
			return
		end

		@session = Session.new(params[:session])
		@session.random = generate_id
		if (Session.find_by_random(@session.random) != nil)
			@session.random = generate_id
		end
		cookies[:random] = @session.random
		config_opentok

		@new_room = Room.new
		@location = "localhost" #CHANGE THIS WHEN DEPLOYED!!
		session_properties = {OpenTok::SessionPropertyConstants::P2P_PREFERENCE => "enabled"}    # or disabled
		session = @opentok.create_session( @location, session_properties )
		@new_room.openTokID = session.session_id
		@new_room.name = @session.random
		@session.save
		@new_room.session_id = @session.id
		@new_room.save
		redirect_to('/interviewer', :notice => 'The URL is interviewr.us/' + @session.random)
	end

	def show
		@session = Session.find_by_random(cookies[:random])
		config_opentok
		@token = @opentok.generate_token :session_id => @session.room.openTokID
	end

	def destroy
		@session = Session.find_by_random(cookies[:random])
		cookies[:random] = nil
		@session.destroy
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
