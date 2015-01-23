class Event < ActiveRecord::Base
  belongs_to :organizer, :foreign_key => :organizer_id, class_name: "User"
  #incorrecto:
  #has_one :organizer, :foreign_key => :organizer_id, class_name: "User"
end
