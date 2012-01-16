class TransactionsController < ApplicationController
  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @transaction = Transaction.find(params[:id])

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
    
    # Check if this form has been submitted already.
    @submit
    unless params[:time].nil?
      form_time = Time.parse(params[:time])
      @submit = Submit.find_by_time(form_time)
    end

    respond_to do |format|
      if @submit.nil? && @transaction.save
        
        # track that this form time has been successfully submitted
        @submit = Submit.new(:time => form_time)
        @submit.save!
        
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        @envelope = @transaction.envelope
        format.js
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
    @transaction = Transaction.find(params[:id])
    
    # Check if this form has been submitted already.
    @submit
    unless params[:time].nil?
      form_time = Time.parse(params[:time])
      @submit = Submit.find_by_time(form_time)
    end

    respond_to do |format|
      if @submit.nil? && @transaction.update_attributes!(params[:transaction])
        
        # track that this form time has been successfully submitted
        @submit = Submit.new(:time => form_time)
        @submit.save!
        
        format.html { redirect_to :root, notice: 'Transaction was successfully updated.' }
        format.js
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.js
      format.json { head :ok }
    end
  end
end
