class IntervieweeSession < ActiveRecord::Base
  attr_accessible :random
  has_one :room
  validate :session_is_in_system
  validates_uniqueness_of :random
  #Validate the uniqueness of random and validate that random exists in sessions table

  private
  def session_is_in_system
    if (Session.find_by_random(self.random) == nil)
      errors.add(:double, "is not an active in the system")
      IntervieweeSession.find_by_random(self.random).destroy if IntervieweeSession.find_by_random(self.random) != nil
      return false
    end
    return true
  end
end
