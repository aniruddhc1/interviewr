class SessionsController < ApplicationController
	def create
		@session = Session.new(params[:session])
		@session.id = generate_id
		if (Session.find_by_id(@session.id) != nil)
			@session.id = generate_id
		end
		@session.save
		redirect_to(session_path, :notice => 'The URL is interviewr.us/' + @session.id)
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
