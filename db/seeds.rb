# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: "1234@gmail") do |admin|
   admin.password = '123456'
end


 user1 = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.last_name = "Santa"
  user.first_name = "Olivia"
  user.last_name_kana = "サンタ"
  user.first_name_kana = "オリビア"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

 user2 = User.find_or_create_by!(email: "james@example.com") do |user|
  user.last_name = "Santa"
  user.first_name = "James"
  user.last_name_kana = "サンタ"
  user.first_name_kana = "ジェームズ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

 user3 = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.last_name = "Santa"
  user.first_name = "Lucas"
  user.last_name_kana = "サンタ"
  user.first_name_kana = "ルーカス"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

 user4 = User.find_or_create_by!(email: "tarou@example.com") do |user|
  user.last_name = "林"
  user.first_name = "太郎"
  user.last_name_kana = "ハヤシ"
  user.first_name_kana = "タロウ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")
end

 user5 = User.find_or_create_by!(email: "zirou@example.com") do |user|
  user.last_name = "小林"
  user.first_name = "二郎"
  user.last_name_kana = "こばやし"
  user.first_name_kana = "ジロウ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")
end

 user6 = User.find_or_create_by!(email: "saburou@example.com") do |user|
  user.last_name = "大林"
  user.first_name = "三郎"
  user.last_name_kana = "オオバヤシ"
  user.first_name_kana = "サブロウ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"), filename:"sample-user6.jpg")
end

 user7 = User.find_or_create_by!(email: "hanako@example.com") do |user|
  user.last_name = "森"
  user.first_name = "花子"
  user.last_name_kana = "モリ"
  user.first_name_kana = "ハナコ"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user7.jpg"), filename:"sample-user7.jpg")
end

location1 = Location.find_or_create_by!(place_name: "富士") do |location|
  location.latitude = "35.46318660000001"
  location.longitude = "138.5837799"
  location.description = "富士本西湖リゾート"
  #location.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end


location2 =  Location.find_or_create_by!(place_name: "上野御徒町") do |location|
  location.latitude = "35.7085706"
  location.longitude = "139.7751029"
  location.description = "東京御徒町"
  #location.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end

location3 =  Location.find_or_create_by!(place_name: "池袋ルミネ") do |location|
  location.latitude = "35.7289148"
  location.longitude = "139.7096495"
  location.description = "池袋駅"
 # location.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end

location4 = Location.find_or_create_by!(place_name: "所沢") do |location|
  location.latitude = "35.7869953"
  location.longitude = "139.4733285"
  location.description = "所沢の奥の方にあったよ"
  #location.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end


location5 = Location.find_or_create_by!(place_name: "池袋駅") do |location|
  location.latitude = "35.7289148"
  location.longitude = "139.7096495"
  location.description = "池袋駅"
 # location.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end

location6 = Location.find_or_create_by!(place_name: "池袋") do |location|
  location.latitude = "35.7289148"
  location.longitude = "139.7096495"
  location.description = "池袋駅"
 # location.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end

location7 = Location.find_or_create_by!(place_name: "御徒町") do |location|
  location.latitude = "35.7085706"
  location.longitude = "139.7751029"
  location.description = "東京御徒町"
  #location.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end

# ユーザーが `user_id` として指定されたユーザーで、`location_id` が `location_id` で指定された場所に関する投稿
Post.find_or_create_by!(user_id: user1.id, location_id: location1.id) do |post|
  post.caption = "ここは素晴らしい場所です。"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
end

# 別の投稿
Post.find_or_create_by!(user_id: user2.id, location_id: location2.id) do |post|
  post.caption = "鴨ラーメン！"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
end

# 更に別の投稿
Post.find_or_create_by!(user_id: user3.id, location_id: location3.id) do |post|
  post.caption = "ワッフル美味しかったよ。"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
end

Post.find_or_create_by!(user_id: user4.id, location_id: location4.id) do |post|
  post.caption = "パンケーキはふわふわ系だったよ。"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
end

# 別の投稿
Post.find_or_create_by!(user_id: user5.id, location_id: location5.id) do |post|
  post.caption = "和風パスタ！"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg")
end

# 更に別の投稿
Post.find_or_create_by!(user_id: user6.id, location_id: location6.id) do |post|
  post.caption = "お豆腐ティラミス。"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg")
end

Post.find_or_create_by!(user_id: user7.id, location_id: location7.id) do |post|
  post.caption = "プリン！"
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post7.jpg")
end
