class Session < ActiveRecord::Base
  attr_accessible :company, :interviewer, :random
  validates_uniqueness_of :random
end
