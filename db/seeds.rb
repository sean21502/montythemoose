require 'random_data'
require 'faker'

User.create!(
  email: 'brit@gmail.com',
  password: 'helloworld',
  confirmed_at: '2016-08-14'
)

admin = User.create!(
   email:    'admin@gmail.com',
   password: 'helloworld',
   confirmed_at: '2016-08-14'
)
admin.role = :admin

5.times do
  User.create!(
    email:    RandomData.random_email,
    password: RandomData.random_sentence,
    confirmed_at: '2016-08-14'
  )
end
users = User.all

10.times do
	Wiki.create!(
		user:  users.sample,
		title:  RandomData.random_sentence,
		body:  RandomData.random_paragraph 
	)
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} topics created"