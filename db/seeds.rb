# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Users
20.times do
  email = Faker::Internet.email
  name = Faker::Name.name
  uid = SecureRandom.uuid
  provider = ""
  image_url = nil
  avatar = nil
  password = "password"
  user = User.new(
  email: email,
  name: name,
  uid: uid,
  provider: provider,
  image_url: image_url,
  avatar: avatar,
  password: password,
  password_confirmation: password,
  )
  user.skip_confirmation!
  user.save
end
# Topics
50.times do
  user_id = User.select(:id).sample.id
  content = Faker::Lorem.sentence
  topic = Topic.new(
  content: content,
  user_id: user_id,
  )
  topic.save
end
# Comments
100.times do
  topic_id = Topic.select(:id).sample.id
  user_id = Topic.find(topic_id).user_id
  content = Faker::Lorem.sentence
  comment = Comment.new(
  user_id: user_id,
  topic_id: topic_id,
  content: content,
  )
  comment.save
end
# Conversations
20.times do
  sender = User.select(:id).sample
  recipient = User.select(:id).slice(sender.id)
  if recipient.nil?
    break
  end
  conversation = Conversation.new(
  sender_id: sender.id,
  recipient_id: recipient.id,
  )
  conversation.save
end
# Messages
100.times do
  conversation = Conversation.all.sample
  user_id = [conversation.sender_id, conversation.recipient_id].sample
  body =  Faker::Lorem.sentence
  message = Message.new(
  body: body,
  conversation_id: conversation.id,
  user_id: user_id
  )
  message.save
end
# Relationships
100.times do
  follower = User.select(:id).sample
  followed = User.select(:id).slice(follower.id)
  if followed.nil?
    break
  end
  unless Relationship.find_by(follower_id: follower.id, followed_id: followed.id).present?
    relationship = Relationship.new(
    follower_id: follower.id,
    followed_id: followed.id,
    )
    relationship.save
  end
end
