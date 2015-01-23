class Event < ActiveRecord::Base

  belongs_to :organizer, :foreign_key => :organizer_id, class_name: "User"
  #incorrecto:
  #has_one :organizer, :foreign_key => :organizer_id, class_name: "User"
  has_many :taggings
  has_many :tags, through: :taggings


  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :title,
      [:title, :start_date],
      [:title, :start_date, :location]
    ]
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |t|
      Tag.where(name: t.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(' ')
  end

end
