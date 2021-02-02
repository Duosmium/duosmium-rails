class Result < ApplicationRecord
  validates :name, presence: true
  validates :data, presence: true
end
