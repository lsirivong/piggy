class Budget < ActiveRecord::Base
  has_many :envelopes
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validate :end_must_be_after_start
  
  def end_must_be_after_start
    if -1 == (end_date <=> start_date)
      errors.add(:end_date, "must be after start date")
    end
  end
end
