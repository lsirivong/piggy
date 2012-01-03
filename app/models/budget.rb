class Budget < ActiveRecord::Base
  has_many :envelopes, :dependent => :destroy
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validate :end_must_be_after_start
  
  def end_must_be_after_start
    if (!end_date.nil? && !start_date.nil? && (end_date <=> start_date) <= 0)
      errors.add(:end_date, "must be after start date")
    end
  end
end
