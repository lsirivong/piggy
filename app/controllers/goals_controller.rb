class GoalsController < ApplicationController
  before_filter :require_goal_ownership, :except => [:new, :create, :index]

  # GET /goals/1
  # GET /goals/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal }
    end
  end

  # GET /goals
  # GET /goals.json
  def index
    @all_goals = current_user.goals

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all_goals}
    end
  end

  # GET /goals/new
  # GET /goals/new.json
  def new
    @goal = Goal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal }
    end
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(params[:goal])
    @goal.user_id = current_user.id

    respond_to do |format|
      if @goal.save
        format.html { redirect_to :root, notice: 'Goal was successfully created.' }
        format.json { render json: @goal, status: :created, location: @goal }
      else
        format.html { render action: "new" }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goals/1
  # PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update_attributes(params[:goal])
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :ok }
    end
  end

  def move_to_budget
    budget = current_user.latest_budget
    Transaction.create(:goal => @goal,
      :vendor => "Funding from goal: [#{@goal.name}]",
      :amount => @goal.total,
      :envelope => budget.envelopes.first,
      :date => Date.today,
      :is_generated => true)

    if @goal.update_attributes(:is_active => false)
      redirect_to budget, notice: 'Goal was successfully moved into budget.'
    else
      redirect_to :root, notice: 'Unable to archive goal.'
    end
  end

  private

  def require_goal_ownership
    @goal = Goal.find(params[:id])
    require_ownership(@goal.user.id) if @goal
  end
end
