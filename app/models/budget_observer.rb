class BudgetObserver < ActiveRecord::Observer
  def after_create(a_budget)
    Envelope.create(:budget_id => a_budget.id, :name => 'Savings', :budget_percent => 20)
    Envelope.create(:budget_id => a_budget.id, :name => 'Wants', :budget_percent => 30)
    Envelope.create(:budget_id => a_budget.id, :name => 'Needs', :budget_percent => 50)
  end
end
