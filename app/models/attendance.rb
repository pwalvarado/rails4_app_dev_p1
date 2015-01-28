class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user_id,  :uniqueness => {:scope => :event_id, :message => "has been sent a join request before"}

  def self.join_event(user_id, event_id,state)
    self.create(user_id: user_id, event_id: event_id, state: state)
  end

end
