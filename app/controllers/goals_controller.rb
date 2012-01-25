class GoalsController < ApplicationController
  before_filter :require_goal_ownership, :except => [:new, :create]

  # GET /goals/1
  # GET /goals/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal }
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
        format.html { redirect_to :root, notice: 'Goal was successfully updated.' }
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

  private

  def require_goal_ownership
    @goal = Goal.find(params[:id])
    require_ownership(@goal.user.id) if @goal
  end
end
