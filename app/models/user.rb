class User < ApplicationRecord
  # Devise modules: authentication, registration, password recovery, session memory
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # roles (0 = admin has full access, 1 = member has not)
  enum :role, { admin: 0, member: 1 }, validate: true


  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }


  scope :admins, -> { where(role: :admin) }
  scope :members, -> { where(role: :member) }


  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end
end
