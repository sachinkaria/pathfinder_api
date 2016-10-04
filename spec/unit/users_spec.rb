require 'rails_helper'

describe UsersController, 'testing users' do
  let(:json) { JSON.parse(response.body) }
  let(:auth_error) {{"errors"=>["Authorized users only."]}}

  before(:each) do
    @bob = create(:user_with_post)
    @post = Post.create(description: "Hello World")
    @auth_headers = @bob.create_new_auth_token
  end

  it 'displays posts if logged in', type: :request do
    get "/users/#{@bob.id}", {}, @auth_headers
    expect(json[0]['description']).to eq("First Post")
  end

  it 'does not display users posts if logged out', type: :request do
    get "/", {}, {}
    expect(json).to eq(auth_error)
  end
end
