# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

nicknames = ['宍戸','ススム','峰雄','ナオユキ','伊豆丸','サトシ','タケシ','yuya','hirohide','kenta','美香','naomi','真紀']
count = 0
while(count < nicknames.length) do
  User.create(nickname: nicknames[count], email: [*'a'..'z'].shuffle[0..7].join + '@' + [*'a'..'z'].shuffle[3..7].join + '.' + [*'a'..'z'].shuffle[3..5].join, password: [*'A'..'Z', *'a'..'z', *0..9].shuffle[0..7].join )
  count = count + 1
end

count = 0
while(count < 50) do
  correct_cnt = rand(210)
  user_id = User.offset( rand(User.count) ).first.id
  qfile_id = Qfile.offset( rand(Qfile.count) ).first.id
  Result.create(user_id: user_id, qfile_id: qfile_id, correct_cnt: correct_cnt, wrong_cnt: rand(40), elapsed_time: rand(30), speed: correct_cnt/30.0)
  count = count + 1
end
