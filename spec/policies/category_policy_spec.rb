require 'rails_helper'

RSpec.describe CategoryPolicy, type: :policy do
  let(:admin_user) { create(:user, :admin) }
  let(:member_user) { create(:user) }
  let(:category) { create(:category) }

  context "as an admin user" do
    let(:policy) { CategoryPolicy.new(admin_user, category) }

    it "allows index" do
      expect(policy.index?).to be true
    end

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "allows new" do
      expect(policy.new?).to be true
    end

    it "allows create" do
      expect(policy.create?).to be true
    end

    it "allows edit" do
      expect(policy.edit?).to be true
    end

    it "allows update" do
      expect(policy.update?).to be true
    end

    it "allows destroy" do
      expect(policy.destroy?).to be true
    end
  end

  context "as a member user" do
    let(:policy) { CategoryPolicy.new(member_user, category) }

    it "allows index" do
      expect(policy.index?).to be true
    end

    it "allows show" do
      expect(policy.show?).to be true
    end

    it "denies new" do
      expect(policy.new?).to be false
    end

    it "denies create" do
      expect(policy.create?).to be false
    end

    it "denies edit" do
      expect(policy.edit?).to be false
    end

    it "denies update" do
      expect(policy.update?).to be false
    end

    it "denies destroy" do
      expect(policy.destroy?).to be false
    end
  end

  context "as an anonymous user" do
    let(:policy) { CategoryPolicy.new(nil, category) }

    it "denies index" do
      expect(policy.index?).to be false
    end

    it "denies show" do
      expect(policy.show?).to be false
    end

    it "denies create" do
      expect(policy.create?).to be false
    end

    it "denies destroy" do
      expect(policy.destroy?).to be false
    end
  end

  describe "Scope" do
    let(:admin_user) { create(:user, :admin) }
    let(:member_user) { create(:user) }

    before do
      create_list(:category, 3)
    end

    context "for admin" do
      it "includes all categories" do
        scope = Pundit.policy_scope!(admin_user, Category)
        expect(scope.count).to be >= 3
      end
    end

    context "for member" do
      it "includes all categories" do
        scope = Pundit.policy_scope!(member_user, Category)
        expect(scope.count).to be >= 3
      end
    end

    context "for anonymous user" do
      it "includes no categories" do
        scope = Pundit.policy_scope!(nil, Category)
        expect(scope.count).to eq(0)
      end
    end
  end
end
