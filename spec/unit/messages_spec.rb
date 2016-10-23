require 'rails_helper'


describe ConversationsController, 'testing conversations' do
  let(:json) { JSON.parse(response.body) }
  let(:auth_error) {{"errors"=>["Authorized users only."]}}

  before(:each) do
    @user1 = create :user
    @user2 = create :user, email: 'john@john.com'
    @user3 = create :user, email: 'bill@bill.com'
    @conversation = Conversation.create(sender_id: @user1.id, recipient_id: @user2.id)
    @firstmessage = @conversation.messages.create(body: "Hey man, how are you?", user_id: @user1.id)
    @auth_headers_user1 = @user1.create_new_auth_token
    @auth_headers_user2 = @user2.create_new_auth_token
    @auth_headers_user3 = @user3.create_new_auth_token
  end

  it 'displays existing messages as sender', type: :request do
    get "/conversations/#{@conversation.id}/messages", {}, @auth_headers_user1
    expect(json[0]['body']).to eq(@firstmessage.body)
  end

  it 'displays existing messages as recipient', type: :request do
    get "/conversations/#{@conversation.id}/messages", {}, @auth_headers_user2
    expect(json[0]['body']).to eq(@firstmessage.body)
  end

  it 'allow user to create a message', type: :request do
    post "/conversations/#{@conversation.id}/messages.json", {body: "Good", user_id: @user2.id}, @auth_headers_user2
    expect(Message.last.body).to eq("Good")
  end

  it 'displays auth error if user not authenticated', type: :request do
    get "/conversations/#{@conversation.id}/messages", {}, {}
    expect(json).to eq(auth_error)
  end


end
