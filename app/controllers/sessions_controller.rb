class SessionsController < ApplicationController
	def new
		@session = Session.new
	end
	def create
		@session = Session.new(params[:session])
		@session.random = generate_id
		if (Session.find_by_random(@session.random) != nil)
			@session.random = generate_id
		end
		session[:random] = @session.random
		@session.save
		redirect_to(@session, :notice => 'The URL is interviewr.us/' + @session.random)
	end

	def show
		@session = Session.find_by_random(session[:random])
	end

	def destroy
		@session = Session.find_by_random(session[:random])
		session[:random] = nil
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
