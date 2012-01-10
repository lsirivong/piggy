class Transaction < ActiveRecord::Base
  validates :date,    :presence => true
  validates :vendor,  :presence => true
  validates :amount,  :presence => true,
                      :format   => { 
                        :with => /\A-?[[:digit:]]+\.?[[:digit:]]{,2}\Z/,
                        :message => "Must be a number with at most two decimal places."
                      }
  validate :envelope_must_exist_if_given
  validate :goal_must_exist_if_given
                      
  belongs_to :envelope
  belongs_to :goal
  
  def budget
    unless envelope.nil?
      envelope.budget
    else
      # no envelope, no budget.
      nil
    end
  end
  
  def envelope_must_exist_if_given
    if !envelope_id.nil? && envelope.nil?
      errors.add(:envelope, "assigned envelope does not exist")
    end
  end
  
  def goal_must_exist_if_given
    if !goal_id.nil? && goal.nil?
      errors.add(:goal, "assigned goal does not exist")
    end
  end
end
