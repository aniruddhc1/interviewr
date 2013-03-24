class Session < ActiveRecord::Base
  attr_accessible :active, :company_name, :interviewee_name, :interviewer_name, :position, :session_id
end
