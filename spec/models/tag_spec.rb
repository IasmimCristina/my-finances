require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "Validations" do
    subject { build(:tag) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(50) }

    context "when creating a tag with duplicate name" do
      it "is invalid" do
        create(:tag, name: "essencial")
        duplicate = build(:tag, name: "essencial")
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:name]).to be_present
      end
    end

    context "when name is too short" do
      it "is invalid" do
        tag = build(:tag, name: "A")
        expect(tag).not_to be_valid
        expect(tag.errors[:name]).to be_present
      end
    end

    context "when name is too long" do
      it "is invalid" do
        tag = build(:tag, name: "A" * 51)
        expect(tag).not_to be_valid
        expect(tag.errors[:name]).to be_present
      end
    end
  end

  describe "Associations" do
    it { is_expected.to have_many(:transaction_tags).dependent(:destroy) }
    it { is_expected.to have_many(:transactions).through(:transaction_tags) }
  end

  describe "Scopes" do
    before do
      @zebra = create(:tag, name: "Zebra")
      @apple = create(:tag, name: "Apple")
      @banana = create(:tag, name: "Banana")
    end

    describe ".ordered" do
      it "returns tags ordered by name" do
        ordered = Tag.ordered
        names = ordered.map(&:name)
        expect(names).to eq(["Apple", "Banana", "Zebra"])
      end
    end
  end
end
