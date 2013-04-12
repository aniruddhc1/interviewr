class RoomsController < ApplicationController

  def create

    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/party/"+@new_room.id.to_s) }
      else
        format.html { render :controller => 'rooms',
               :action => "index" }
      end
    end
  end

  def party
    @room = Room.find(params[:id])

    config_opentok

    @tok_token = @opentok.generate_token :session_id =>
          @room.sessionId
  end

  private
  def config_opentok
    if @opentok.nil?
      @opentok = OpenTok::OpenTokSDK.new {22586622}, {f6bfae97fc2a3140a327d9d3e56d88ced8b86611}
    end
  end
end
