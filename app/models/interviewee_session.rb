class IntervieweeSession < ActiveRecord::Base
  attr_accessible :random
  validates_uniqueness_of :random
  validate :session_is_in_system
  #Validate the uniqueness of random and validate that random exists in sessions table

  private
  def session_is_in_system
    if (Session.find_by_random(self.random) == nil)
      errors.add(:double, "is not an active in the system")
      return false
    end
    return true
  end
end
