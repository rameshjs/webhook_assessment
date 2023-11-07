class ApiSecret < ApplicationRecord
  validates :key, uniqueness: true
end
