class Budget < ActiveRecord::Base
  has_many :envelopes, :dependent => :destroy
  has_many :transactions, :through => :envelopes, :order => 'date DESC, created_at DESC'
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validate :end_must_be_after_start
  
  accepts_nested_attributes_for :envelopes
  
  def end_must_be_after_start
    if (end_date.present? && start_date.present? && (end_date <=> start_date) <= 0)
      errors.add(:end_date, "must be after start date")
    end
  end
  
  def previous_budget
    self.class.first(:conditions => ["created_at < ?", created_at], :order => "created_at desc")
  end

  def next_budget
    self.class.first(:conditions => ["created_at > ?", created_at], :order => "created_at asc")
  end
  
  include Ledger # requires sum and amount methods
  def sum
    transactions.sum(:amount)
  end
end
