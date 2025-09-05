class Book < ApplicationRecord
  has_many :loans, dependent: :destroy
  has_many :users, through: :loans
end
