class Board < ActiveRecord::Base
  belongs_to :user

  has_many :pins
  accepts_nested_attributes_for :pins

  extend FriendlyId
  friendly_id :title, use: :slugged
end
