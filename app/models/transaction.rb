class Transaction < ActiveRecord::Base
  validates :date,    :presence => true
  validates :vendor,  :presence => true
  validates :amount,  :presence => true,
                      :format   => { 
                        :with => /\A-?[[:digit:]]+\.?[[:digit:]]{,2}\Z/,
                        :message => "Must be a number with at most two decimal places."
                      }
  validate :envelope_must_exist_if_given
                      
  belongs_to :envelope
  
  def envelope_must_exist_if_given
    if !envelope_id.nil? && envelope.nil?
      errors.add(:envelope, "assigned envelope does not exist")
    end
  end
end
