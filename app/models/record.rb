class Record < ApplicationRecord
  belongs_to :user

  validates :tittle, presence: true
  validates :year, presence: true
end
