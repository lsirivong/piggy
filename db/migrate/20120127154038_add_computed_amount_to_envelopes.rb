class AddComputedAmountToEnvelopes < ActiveRecord::Migration
  def up
    add_column :envelopes, :computed_amount, :decimal

    Envelope.reset_column_information

    Envelope.all.each do |e|
      e.update_attributes(:computed_amount => ((e.budget_percent / BigDecimal.new("100")) * e.budget.amount)) if e.budget
    end
  end

  def down
    remove_column :envelopes, :computed_amount
  end
end
