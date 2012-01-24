class BudgetsController < ApplicationController
  before_filter :require_budget_ownership, :except => [:new, :create]

  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @goals = Goal.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @budget }
    end
  end

  # GET /budgets/new
  # GET /budgets/new.json
  def new
    session[:no_budgets_found] = Budget.count <= 0
    
    if current_user.latest_budget
      @budget = Budget.new(:amount => current_user.latest_budget.amount,
        :start_date => current_user.latest_budget.end_date + 1,
        :end_date => current_user.latest_budget.end_date + 1 + current_user.latest_budget.days_long)
    else
      today = Date.today
      @budget = Budget.new(:amount => 0, :start_date => today, :end_date => (today + 14)) # 2 weeks
    end
    
    @budget.envelopes << Envelope.new(:name => 'Needs', :budget_percent => 50, :budget => @budget )
    @budget.envelopes << Envelope.new(:name => 'Wants', :budget_percent => 30, :budget => @budget )
    @budget.envelopes << Envelope.new(:name => 'Savings', :budget_percent => 20, :budget => @budget )
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @budget }
    end
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(params[:budget])
    @budget.user_id = current_user.id

    respond_to do |format|
      if @budget.save
        format.html { redirect_to :root, notice: 'Budget was successfully created.' }
        format.json { render json: @budget, status: :created, location: @budget }
      else
        format.html { render action: "new" }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /budgets/1
  # PUT /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update_attributes(params[:budget])
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :ok }
    end
  end

  private

  def require_budget_ownership
    @budget = Budget.find(params[:id])
    require_ownership(@budget.user.id) if @budget
  end
end
