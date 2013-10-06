class ArchesController < ApplicationController
  load_and_authorize_resource
  check_authorization

  # GET /arches
  # GET /arches.json
  def index
    @arches = Arch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @arches }
    end
  end

  # GET /arches/1
  # GET /arches/1.json
  def show
    @arch = Arch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @arch }
    end
  end

  # GET /arches/new
  # GET /arches/new.json
  def new
    @arch = Arch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @arch }
    end
  end

  # GET /arches/1/edit
  def edit
    @arch = Arch.find(params[:id])
  end

  # POST /arches
  # POST /arches.json
  def create
    @arch = Arch.new(params[:arch])

    respond_to do |format|
      if @arch.save
        format.html { redirect_to @arch, notice: 'Arch was successfully created.' }
        format.json { render json: @arch, status: :created, location: @arch }
      else
        format.html { render action: "new" }
        format.json { render json: @arch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /arches/1
  # PUT /arches/1.json
  def update
    @arch = Arch.find(params[:id])

    respond_to do |format|
      if @arch.update_attributes(params[:arch])
        format.html { redirect_to @arch, notice: 'Arch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @arch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arches/1
  # DELETE /arches/1.json
  def destroy
    @arch = Arch.find(params[:id])
    @arch.destroy

    respond_to do |format|
      format.html { redirect_to arches_url }
      format.json { head :no_content }
    end
  end
end
