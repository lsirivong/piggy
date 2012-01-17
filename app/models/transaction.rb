class Transaction < ActiveRecord::Base
  validates :date,    :presence => true
  validates :vendor,  :presence => true
  validates :amount,  :format   => {
                        :with => /\A-?[[:digit:]]+\.?[[:digit:]]{,2}\Z/,
                        :message => "must be a number with at most two decimal places."
                      }
  validate :envelope_must_exist_if_given
  validate :goal_must_exist_if_given
  validate :amount_display_format
                      
  belongs_to :envelope
  belongs_to :goal
  
  # virtual attribute
  def amount_display
    if amount.nil?
      return nil
    elsif 0 < amount
      return "+#{amount}"
    else
      return "#{amount.abs}"
    end
  end
  
  def amount_display=(amount_display)
    if amount_display.present?
      
      # validate amount_display format
      if (/\A[-\+]?[[:digit:]]+\.?[[:digit:]]{,2}\Z/ =~ amount_display).nil?
        # set the amount to a dummy value to circumvent amount validation
        self.amount = 0
        raise ArgumentError
      end
      
      if amount_display.strip.start_with?('+')
        self.amount = (BigDecimal.new(amount_display).abs)
      else
        self.amount = -1*(BigDecimal.new(amount_display).abs)
      end
    end
  rescue ArgumentError
    @invalid_amount = true
  end
  
  def amount_display_format
    errors.add(:amount, "must be a number with at most two decimal places.") if @invalid_amount
  end
  
  def budget
    unless envelope.nil?
      envelope.budget
    else
      # no envelope, no budget.
      nil
    end
  end
  
  def budgets
    unless budget.nil?
      Envelope.where(:budget_id => budget.id)
    else
      Envelope.all
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
