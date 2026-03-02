require 'rails_helper'

RSpec.describe User, type: :model do
  # VALIDATIONS


  describe "Validations" do
    subject { build(:user) }

    # Name validation
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(100) }

    # Email validation (from Devise)
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    context "when email format is invalid" do
      it "rejects email without @" do
        user = build(:user, email: "invalid_email")
        expect(user).not_to be_valid
        expect(user.errors[:email]).to be_present
      end
    end
  end


  # ASSOCIATIONS & ATTRIBUTES


  describe "Attributes" do
    it "responds to name, email, role" do
      user = build(:user)
      expect(user).to respond_to(:name)
      expect(user).to respond_to(:email)
      expect(user).to respond_to(:role)
    end
  end


  # ENUMS


  describe "Enums" do
    context "role enum" do
      it "has admin role (0)" do
        user = build(:user, :admin)
        expect(user).to be_admin
        expect(user.role).to eq("admin")
      end

      it "has member role (1)" do
        user = build(:user) # default is member
        expect(user).to be_member
        expect(user.role).to eq("member")
      end

      it "raises error for invalid role" do
        expect { User.new(role: :invalid) }.to raise_error(ArgumentError)
      end
    end
  end


  # SCOPES


  describe "Scopes" do
    before do
      create(:user, :admin)
      create(:user, :admin)
      create(:user) # member
      create(:user) # member
    end

    describe ".admins" do
      it "returns only admin users" do
        admins = User.admins
        expect(admins).to all(be_admin)
        expect(admins.count).to eq(2)
      end
    end

    describe ".members" do
      it "returns only member users" do
        members = User.members
        expect(members).to all(be_member)
        expect(members.count).to eq(2)
      end
    end
  end


  # INSTANCE METHODS


  describe "Instance Methods" do
    describe "#admin?" do
      it "returns true for admin users" do
        user = build(:user, :admin)
        expect(user.admin?).to be true
      end

      it "returns false for member users" do
        user = build(:user)
        expect(user.admin?).to be false
      end
    end

    describe "#member?" do
      it "returns true for member users" do
        user = build(:user)
        expect(user.member?).to be true
      end

      it "returns false for admin users" do
        user = build(:user, :admin)
        expect(user.member?).to be false
      end
    end
  end


  # DEVISE INTEGRATION


  describe "Devise Integration" do
    it "encrypts password on create" do
      user = create(:user, password: "MyPassword123!")
      expect(user.encrypted_password).not_to be_blank
      expect(user.encrypted_password).not_to eq("MyPassword123!")
    end

    it "allows user to authenticate with correct password" do
      user = create(:user, password: "CorrectPassword123!")
      authenticated_user = User.find_by(email: user.email)
      expect(authenticated_user.valid_password?("CorrectPassword123!")).to be true
    end

    it "rejects authentication with wrong password" do
      user = create(:user, password: "CorrectPassword123!")
      authenticated_user = User.find_by(email: user.email)
      expect(authenticated_user.valid_password?("WrongPassword123!")).to be false
    end
  end
end
