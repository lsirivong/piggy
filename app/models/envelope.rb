class Envelope < ActiveRecord::Base
  validates :budget_percent, :presence => true
  has_many :transactions, :dependent => :destroy
  belongs_to :budget
  
  accepts_nested_attributes_for :transactions, :reject_if => :all_blank, :allow_destroy => true

  include Ledger # requires sum and amount methods

  def sum
    transactions.sum(:amount)
  end

  def amount
    self.computed_amount
  end

  before_save do |envelope|
    envelope.compute_amount
  end

  before_update do |envelope|
    envelope.compute_amount
  end

  def compute_amount
    if budget
      self.computed_amount = calculate_amount(self.budget_percent, self.budget.amount)
    else
      self.computed_amount = 0
    end
  end
  
  private

  def calculate_amount(percent, budget_amount)
    ((percent / BigDecimal("100")) * budget_amount).round(+2)
  end
end
