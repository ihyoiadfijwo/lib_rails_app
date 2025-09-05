class User < ApplicationRecord
  has_secure_password
  has_many :loans, dependent: :destroy
  has_many :books, through: :loans
end
