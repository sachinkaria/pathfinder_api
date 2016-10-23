require 'rails_helper'


describe ConversationsController, 'testing conversations' do
  let(:json) { JSON.parse(response.body) }
  let(:auth_error) {{"errors"=>["Authorized users only."]}}

  before(:each) do
    @user1 = create :user
    @user2 = create :user, email: 'john@john.com'
    @user3 = create :user, email: 'bill@bill.com'
    @conversation = Conversation.create(sender_id: @user1.id, recipient_id: @user2.id)
    @auth_headers_user1 = @user1.create_new_auth_token
    @auth_headers_user2 = @user2.create_new_auth_token
    @auth_headers_user3 = @user3.create_new_auth_token
  end

  it 'displays existing conversations as sender', type: :request do
    get '/conversations', {}, @auth_headers_user1
    expect(json[0]['sender_id']).to eq(@user1.id)
  end

  it 'displays existing conversations as recipient', type: :request do
    get '/conversations', {}, @auth_headers_user2
    expect(json[0]['recipient_id']).to eq(@user2.id)
  end

  it 'allow user to create a conversation', type: :request do
    post '/conversations.json', {sender_id: @user1.id, recipient_id: @user3.id}, @auth_headers_user1
    expect(Conversation.last.recipient_id).to eq(@user3.id)
  end

  it 'displays auth error if user not authenticated', type: :request do
    get '/', {}, {}
    expect(json).to eq(auth_error)
  end


end
