# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: '1234@gmail',
   password: '123456'
)


 User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.last_name = "Santa"
  user.first_name = "Olivia"
  user.last_name_kana = "サンタ"
  user.first_name_kana = "オリビア"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

 User.find_or_create_by!(email: "james@example.com") do |user|
  user.last_name = "Santa"
  user.first_name = "James"
  user.last_name_kana = "サンタ"
  user.first_name_kana = "ジェームズ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

 User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.last_name = "Santa"
  user.first_name = "Lucas"
  user.last_name_kana = "サンタ"
  user.first_name_kana = "ルーカス"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

# ユーザーが `user_id` として指定されたユーザーで、`location_id` が `location_id` で指定された場所に関する投稿
Post.find_or_create_by!(user_id: 1, location_id: 1) do |post|
  post.caption = "ここは素晴らしい場所です。"
  post.latitude = "35.12345"
  post.longitude = "139.67890"
  post.new_location_name = "新しい場所の名前"
  post.new_location_description = "新しい場所の説明"
end

# 別の投稿
Post.find_or_create_by!(user_id: 2, location_id: 2) do |post|
  post.caption = "この場所は最高です。"
  post.latitude = "35.54321"
  post.longitude = "139.09876"
  post.new_location_name = "新しい場所2の名前"
  post.new_location_description = "新しい場所2の説明"
end

# 更に別の投稿
Post.find_or_create_by!(user_id: 3, location_id: 3) do |post|
  post.caption = "ここも素晴らしい場所です。"
  post.latitude = "35.11111"
  post.longitude = "139.99999"
  post.new_location_name = "新しい場所3の名前"
  post.new_location_description = "新しい場所3の説明"
end
