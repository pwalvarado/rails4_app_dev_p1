class Attendance < ActiveRecord::Base
  include Workflow
  belongs_to :user
  belongs_to :event

  validates :user_id,  :uniqueness => {:scope => :event_id, :message => "has been sent a join request before"}

  def self.join_event(user_id, event_id,state)
    self.create(user_id: user_id, event_id: event_id, state: state)
  end

  workflow_column :state

  workflow do
    state :request_sent do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
    state :accepted
    state :rejected
  end
end
