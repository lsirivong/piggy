class TransactionsController < ApplicationController
  before_filter :prevent_multiple_submission, :only => [:create, :update]
  before_filter :require_transaction_ownership, :except => [:new, :create]
  
  # GET /transactions/1
  # GET /transactions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.json
  def new
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.js
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.js
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to :root, notice: 'Transaction was successfully updated.' }
        format.js
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.js
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.js
      format.json { head :ok }
    end
  end
  
  private
  
  def prevent_multiple_submission
    if params[:form_token].present?
      submission = Submit.find_by_token(params[:form_token])

      if submission.nil?
        submission = Submit.new(:token => params[:form_token])
        submission.save!
      else
        respond_to do |format|
          format.html { redirect_to :root, notice: 'That form has already been submitted.' }
          format.js { head :no_content } # respond with nothing, request is halted
        end
      end
    end
  end

  def require_transaction_ownership
    @transaction = Transaction.find(params[:id])
    require_ownership(@transaction.budget.user.id) if @transaction
  end
end
