class BudgetsController < ApplicationController
  # GET /budgets/1
  # GET /budgets/1.json
  def show
    @budget = Budget.find(params[:id])
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
    
    today = Date.today
    @budget = Budget.new(:amount => 0, :start_date => today, :end_date => (today + 14)) # 2 weeks
    
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
    @budget = Budget.find(params[:id])
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
    @budget = Budget.find(params[:id])

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
    @budget = Budget.find(params[:id])
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :ok }
    end
  end
end
