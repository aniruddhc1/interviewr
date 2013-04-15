class IntervieweeSession < ActiveRecord::Base
  attr_accessible :random
  validate :session_is_in_system
  validate :session_not_taken
  validates_uniqueness_of :random
  #Validate the uniqueness of random and validate that random exists in IntervieweeSessions table

  def room
    Room.find_by_interviewee_session_id(self.id)
  end

  private
  def session_is_in_system
    if (Session.find_by_random(self.random) == nil)
      errors.add(:double, "is not an active in the system")
      return false
    end
    return true
  end

  def session_not_taken
    s = IntervieweeSession.find_by_random(self.random)
    if (s != nil)
      errors.add(:double, "is busy")
      return false
    end
    return true 
  end
end
