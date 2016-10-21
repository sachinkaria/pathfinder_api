class Message < ActiveRecord::Base
 belongs_to :conversation
 belongs_to :user

 validates_presence_of :body, :conversation_id, :user_id

 def as_json(options={})
    super(only: [:id, :conversation_id, :body, :read, :created_at],
    include: [user: { only: [:name] }]
    )
  end
end
