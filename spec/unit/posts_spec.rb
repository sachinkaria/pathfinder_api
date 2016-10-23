require 'rails_helper'

describe Post do
  it { is_expected.to belong_to :user}
end

describe PostsController, 'testing posts' do
  let(:json) { JSON.parse(response.body) }
  let(:auth_error) {{"errors"=>["Authorized users only."]}}
  let(:new_post_params) { attributes_for(:post, description: "Third Post") }
  let(:description_edited) { {description: 'Edited'} }

  before(:each) do
    @bob = create :user_with_post
    @post = @bob.posts[0]
    @auth_headers = @bob.create_new_auth_token
    @another_post = create :post, description: 'Second Post'
  end

  it 'displays existing posts', type: :request do
    get '/', {}, @auth_headers
    expect(json[0]['description']).to eq(@post.description)
  end

  it 'shows a specific post request', type: :request do
    get "/posts/#{@post.id}", {}, @auth_headers
    expect(json['description']).to eq(@post.description)
  end


  it 'allows user to create post request', type: :request do
    post '/posts.json', new_post_params, @auth_headers
    expect(Post.last.description).to eq(new_post_params[:description])
  end

  it 'allows user to change description', type: :request do
    patch "/posts/#{@post.id}.json", description_edited, @auth_headers
    expect(@post.description).to eq('Edited')
  end

  it 'displays auth error if user not authenticated', type: :request do
    get '/', {}, {}
    expect(json).to eq(auth_error)
  end
end
