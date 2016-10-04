class Post < ActiveRecord::Base
  belongs_to :user

  def as_json(options={})
    super(only: [:description])
  end
end
