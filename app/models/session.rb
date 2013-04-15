class Session < ActiveRecord::Base
  attr_accessible :company, :interviewer, :random
  validates_uniqueness_of :random
  has_one :room, :dependent => :destroy
end
