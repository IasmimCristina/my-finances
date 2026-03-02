require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Validations" do
    subject { build(:category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(50) }
    it { is_expected.to validate_presence_of(:kind) }

    context "when creating a category with duplicate name" do
      it "is invalid" do
        create(:category, name: "Teste")
        duplicate = build(:category, name: "Teste")
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:name]).to be_present
      end
    end

    context "when name is too short" do
      it "is invalid" do
        category = build(:category, name: "A")
        expect(category).not_to be_valid
        expect(category.errors[:name]).to be_present
      end
    end

    context "when name is too long" do
      it "is invalid" do
        category = build(:category, name: "A" * 51)
        expect(category).not_to be_valid
        expect(category.errors[:name]).to be_present
      end
    end
  end

  describe "Enums" do
    describe "#kind" do
      it "has correct enum values" do
        expect(Category.kinds).to include("expense" => 0, "income" => 1)
      end

      context "when setting kind to expense" do
        it "is valid" do
          category = build(:category, kind: :expense)
          expect(category).to be_valid
        end
      end

      context "when setting kind to income" do
        it "is valid" do
          category = build(:category, kind: :income)
          expect(category).to be_valid
        end
      end
    end
  end

  describe "Scopes" do
    before do
      @expense_cat = create(:category, name: "Test Expense", kind: :expense)
      @income_cat = create(:category, name: "Test Income", kind: :income)
    end

    describe ".expenses" do
      it "returns only expense categories" do
        expect(Category.expenses).to include(@expense_cat)
        expect(Category.expenses).not_to include(@income_cat)
      end
    end

    describe ".incomes" do
      it "returns only income categories" do
        expect(Category.incomes).to include(@income_cat)
        expect(Category.incomes).not_to include(@expense_cat)
      end
    end

    describe ".ordered" do
      it "returns categories ordered by name" do
        z_cat = create(:category, name: "Zebra")
        a_cat = create(:category, name: "Apple")

        ordered = Category.ordered
        names = ordered.map(&:name)
        expect(names).to include("Apple")
        expect(names).to include("Zebra")
        expect(names.index("Apple")).to be < names.index("Zebra")
      end
    end
  end

  describe "Instance Methods" do
    describe "#expense?" do
      context "when kind is expense" do
        it "returns true" do
          category = build(:category, kind: :expense)
          expect(category.expense?).to be true
        end
      end

      context "when kind is income" do
        it "returns false" do
          category = build(:category, kind: :income)
          expect(category.expense?).to be false
        end
      end
    end

    describe "#income?" do
      context "when kind is income" do
        it "returns true" do
          category = build(:category, kind: :income)
          expect(category.income?).to be true
        end
      end

      context "when kind is expense" do
        it "returns false" do
          category = build(:category, kind: :expense)
          expect(category.income?).to be false
        end
      end
    end
  end
end
