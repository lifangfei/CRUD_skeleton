require 'faker'

number_of_users_wanted = 10
new_users_needed = number_of_users_wanted - User.count

new_users_needed.times do
  person = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }
  person[:email] = Faker::Internet.safe_email("#{person[:first_name]}.#{person[:last_name]}")
  user = User.new(person)
  user.password = "xxx"
  user.save!
end
