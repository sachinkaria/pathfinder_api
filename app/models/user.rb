class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, dependent: :destroy


  before_save -> do
    self.uid = SecureRandom.uuid
    skip_confirmation!
  end

  def as_json(options={})
     super(only: [:id, :email, :name],
     include: [posts: { only: [:description, :created_at] }]
       )
   end

  end
