# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 0.22user→0.21user並行処理で僅かに早くなる
require 'parallel'

# ActiveRecordを使ってるから遅い。SQLの直打ちで書くと早くなるらしい。

for n in "a".."d" do
  User.create!(
      email: "#{n}@#{n}",
      name: "#{n}" * 3 ,
      password: "#{n}" * 6
    )
end
for n in 1..4 do
  Book.create!(
        title: "#{n}",
        body: "#{n}" ,
        user_id: "#{n}",
        rate: 5
      )
end
