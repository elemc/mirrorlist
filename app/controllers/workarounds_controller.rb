class WorkaroundsController < ApplicationController
  load_and_authorize_resource
  check_authorization

  # GET /workarounds
  # GET /workarounds.json
  def index
    @workarounds = Workaround.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workarounds }
    end
  end

  # GET /workarounds/1
  # GET /workarounds/1.json
  def show
    @workaround = Workaround.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workaround }
    end
  end

  # GET /workarounds/new
  # GET /workarounds/new.json
  def new
    @workaround = Workaround.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workaround }
    end
  end

  # GET /workarounds/1/edit
  def edit
    @workaround = Workaround.find(params[:id])
  end

  # POST /workarounds
  # POST /workarounds.json
  def create
    @workaround = Workaround.new(params[:workaround])

    respond_to do |format|
      if @workaround.save
        format.html { redirect_to @workaround, notice: 'Workaround was successfully created.' }
        format.json { render json: @workaround, status: :created, location: @workaround }
      else
        format.html { render action: "new" }
        format.json { render json: @workaround.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workarounds/1
  # PUT /workarounds/1.json
  def update
    @workaround = Workaround.find(params[:id])

    respond_to do |format|
      if @workaround.update_attributes(params[:workaround])
        format.html { redirect_to @workaround, notice: 'Workaround was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workaround.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workarounds/1
  # DELETE /workarounds/1.json
  def destroy
    @workaround = Workaround.find(params[:id])
    @workaround.destroy

    respond_to do |format|
      format.html { redirect_to workarounds_url }
      format.json { head :no_content }
    end
  end
end
