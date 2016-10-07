class Post < ActiveRecord::Base
  belongs_to :user

  def as_json(options={})
    super(only: [:description, :created_at, :user_id, :username])
  end
end
