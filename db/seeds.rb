# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Roles
# Role.create([
#                 {title: 'admin'},
#                 {title: 'merchant'},
#                 {title: 'data_entry'},
#                 {title: 'rider'}
#             ])
# admin
role = Role.where('title = ?', 'admin')
user = User.create(email: 'admin@gmail.com', password: '123456', first_name: 'admin', last_name: 'admin', phone_number: '01710000000')
user.roles << role
profile = UserProfile.create(user_id: user.id)

# merchant
role = Role.where('title = ?', 'merchant')
user = User.create(email: 'merchant@gmail.com', password: '123456', first_name: 'merchant', last_name: 'user', phone_number: '01710001111', creator_id: 1)
user.roles << role
profile = UserProfile.create(user_id: user.id)

# data_entry
role = Role.where('title = ?', 'data_entry')
user = User.create(email: 'data_entry@gmail.com', password: '123456', first_name: 'data_entry', last_name: 'user', phone_number: '01710002222', creator_id: 1)
user.roles << role
profile = UserProfile.create(user_id: user.id)

# rider
role = Role.where('title = ?', 'rider')
user = User.create(email: 'rider@gmail.com', password: '123456', first_name: 'rider', last_name: 'user', phone_number: '01710003333', creator_id: 1)
user.roles << role
profile = UserProfile.create(user_id: user.id)