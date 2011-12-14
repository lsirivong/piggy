class EnvelopesController < ApplicationController
  # GET /envelopes
  # GET /envelopes.json
  def index
    @envelopes = Envelope.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @envelopes }
    end
  end

  # GET /envelopes/1
  # GET /envelopes/1.json
  def show
    @envelope = Envelope.find(params[:id])
    
    @transactions = @envelope.transactions unless @envelope.nil?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @envelope }
    end
  end

  # GET /envelopes/new
  # GET /envelopes/new.json
  def new
    @envelope = Envelope.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @envelope }
    end
  end

  # GET /envelopes/1/edit
  def edit
    @envelope = Envelope.find(params[:id])
  end

  # POST /envelopes
  # POST /envelopes.json
  def create
    @envelope = Envelope.new(params[:envelope])

    respond_to do |format|
      if @envelope.save
        format.html { redirect_to @envelope, notice: 'Envelope was successfully created.' }
        format.json { render json: @envelope, status: :created, location: @envelope }
      else
        format.html { render action: "new" }
        format.json { render json: @envelope.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /envelopes/1
  # PUT /envelopes/1.json
  def update
    @envelope = Envelope.find(params[:id])

    respond_to do |format|
      if @envelope.update_attributes(params[:envelope])
        format.html { redirect_to @envelope, notice: 'Envelope was successfully updated.' }
        format.js
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @envelope.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /envelopes/1
  # DELETE /envelopes/1.json
  def destroy
    @envelope = Envelope.find(params[:id])
    @envelope.destroy

    respond_to do |format|
      format.html { redirect_to envelopes_url }
      format.json { head :ok }
    end
  end
end
