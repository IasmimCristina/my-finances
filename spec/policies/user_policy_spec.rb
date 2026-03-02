require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  # Setup: Create test users


  let(:admin_user) { create(:user, :admin) }
  let(:member_user) { create(:user, :member) }
  let(:other_member) { create(:user, :member) }


  # Tests: Admin permissions


  describe "Admin user permissions" do
    subject { UserPolicy.new(admin_user, user) }

    context "accessing any user" do
      let(:user) { other_member }

      it { is_expected.to permit(:index) }
      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:create) }
      it { is_expected.to permit(:update) }
      it { is_expected.to permit(:edit) }
      it { is_expected.to permit(:destroy) }
    end

    context "accessing their own profile" do
      let(:user) { admin_user }

      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:update) }
    end
  end


  # Tests: Member permissions


  describe "Member user permissions" do
    subject { UserPolicy.new(member_user, user) }

    context "accessing their own profile" do
      let(:user) { member_user }

      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:update) }
      it { is_expected.to permit(:edit) }
    end

    context "accessing another member's profile" do
      let(:user) { other_member }

      it { is_expected.not_to permit(:show) }
      it { is_expected.not_to permit(:update) }
      it { is_expected.not_to permit(:edit) }
      it { is_expected.not_to permit(:destroy) }
    end

    context "accessing admin features" do
      let(:user) { other_member }

      it { is_expected.not_to permit(:index) }
      it { is_expected.not_to permit(:create) }
      it { is_expected.not_to permit(:destroy) }
    end
  end


  # Tests: Scope (Filtering visible records)


  describe "Scopes" do
    before do
      admin_user
      member_user
      other_member
    end

    describe "Admin scope" do
      subject { UserPolicy::Scope.new(admin_user, User).resolve }

      it "returns all users" do
        expect(subject.count).to eq(3)
        expect(subject).to include(admin_user, member_user, other_member)
      end
    end

    describe "Member scope" do
      subject { UserPolicy::Scope.new(member_user, User).resolve }

      it "returns only their own user" do
        expect(subject.count).to eq(1)
        expect(subject).to include(member_user)
        expect(subject).not_to include(other_member, admin_user)
      end
    end

    describe "Unauthenticated scope" do
      subject { UserPolicy::Scope.new(nil, User).resolve }

      it "returns no users" do
        expect(subject.count).to eq(0)
      end
    end
  end
end
