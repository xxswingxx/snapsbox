class User < ActiveRecord::Base
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: [:member, :admin], default: :member

  # Associations
  has_many :buttons
  belongs_to :team 
  
  validate :name, uniqueness: { scope: :team_id }
  # Callbacks
  before_create :create_team
  
  # Methods
  private  
  def create_team
    
    if self.invitation_token
      self.team = User.find(self.invited_by_id).team
    else
      self.team = Team.create(name: "Default")
      self.role = :admin
    end
  end
end
