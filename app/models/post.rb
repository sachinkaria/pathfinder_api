class Post < ActiveRecord::Base
  belongs_to :user

  def as_json(options={})
     super(only: [:id, :description, :created_at, :user_id],
     include: [user: { only: [:name] }]
       )
   end
end
