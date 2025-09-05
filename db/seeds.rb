# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# books
Book.create!(title: "Ruby入門", author: "山田太郎", isbn: "1234567890", category: "プログラミング", total_copies: 5)
Book.create!(title: "Railsガイド", author: "佐藤花子", isbn: "0987654321", category: "Web", total_copies: 3)
Book.create!(title: "JavaScript超入門", author: "田中一郎", isbn: "1122334455", category: "プログラミング", total_copies: 7)
# users
User.create!(student_no: 1001, name: "山田 太郎", role: "student", password: "123456")
User.create!(student_no: 1002, name: "鈴木 花子", role: "libadmin", password: "654321")
User.create!(student_no: 1003, name: "佐藤 次郎", role: "sysadmin", password: "111111")