# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  @sachin =  User.create(email: 'sachin@sachin.com', password: 'sachinkaria', password_confirmation: 'sachinkaria', name: 'Sachin Karia')
  @ravi =   User.create(email: 'ravi@ravi.com', password: 'ravikaria', password_confirmation: 'ravikaria', name: 'Ravi Karia')
  @sona =   User.create(email: 'sona@sona.com', password: 'sonakaria', password_confirmation: 'sonakaria', name: 'Sona Karia')

    Conversation.create(sender_id: @sachin.id, recipient_id: @ravi.id)
