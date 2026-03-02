class Category < ApplicationRecord
  enum :kind, { expense: 0, income: 1 }, validate: true


  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :name, uniqueness: true
  validates :kind, presence: true


  scope :expenses, -> { where(kind: :expense) }
  scope :incomes,  -> { where(kind: :income) }
  scope :ordered,  -> { order(:name) }

  # Métodos de predicado (helpers)
  def expense?
    kind == "expense"
  end

  def income?
    kind == "income"
  end
end
