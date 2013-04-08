class IntervieweeSession < ActiveRecord::Base
  attr_accessible :random
  validates_uniqueness_of :random
  validate :session_is_in_system
  #Validate the uniqueness of random and validate that random exists in sessions table
  private
  def session_is_in_system
    # get an array of all active events in the system
    active_session_ids = Session.all.map{|e| e.random}
    # add error unless the event id of the section is in the array of active events
    unless active_session_ids.include?(self.random)
      errors.add(:interviewee_session, "is not an active in the system")
      return false
    end
    return true
  end
end
