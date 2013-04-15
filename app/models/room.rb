class Room < ActiveRecord::Base
  attr_accessible :interviewee_session_id, :name, :openTokID, :session_id
  belongs_to :session



end
