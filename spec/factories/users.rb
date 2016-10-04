FactoryGirl.define do
  factory :user do
    email 'bob@bob.com'
    password '12345678'
    password_confirmation '12345678'

    factory :user_with_post do
      after(:create) do |user|
        create(:post, user: user)
      end
    end
  end
end
