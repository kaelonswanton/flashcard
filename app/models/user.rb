class User < ApplicationRecord
  has_many :decks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :username, presence: true, uniqueness: true

  # Ransack gem - attributes allowed to be search
  def self.ransackable_attributes(auth_object = nil)
    ["username"]
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
