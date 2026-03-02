class User < ApplicationRecord
  # Devise modules: authentication, registration, password recovery, session memory
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enums: user roles (0 = admin has full access, 1 = member has limited access)
  enum :role, { admin: 0, member: 1 }, validate: true

  # Validations
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Scopes for common queries
  scope :admins, -> { where(role: :admin) }
  scope :members, -> { where(role: :member) }

  # Instance methods
  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end
end
