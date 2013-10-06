class RepositoryPortionsController < ApplicationController
  load_and_authorize_resource
  check_authorization

  # GET /repository_portions
  # GET /repository_portions.json
  def index
    @repository_portions = RepositoryPortion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repository_portions }
    end
  end

  # GET /repository_portions/1
  # GET /repository_portions/1.json
  def show
    @repository_portion = RepositoryPortion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repository_portion }
    end
  end

  # GET /repository_portions/new
  # GET /repository_portions/new.json
  def new
    @repository_portion = RepositoryPortion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repository_portion }
    end
  end

  # GET /repository_portions/1/edit
  def edit
    @repository_portion = RepositoryPortion.find(params[:id])
  end

  # POST /repository_portions
  # POST /repository_portions.json
  def create
    @repository_portion = RepositoryPortion.new(params[:repository_portion])

    respond_to do |format|
      if @repository_portion.save
        format.html { redirect_to @repository_portion, notice: 'Repository portion was successfully created.' }
        format.json { render json: @repository_portion, status: :created, location: @repository_portion }
      else
        format.html { render action: "new" }
        format.json { render json: @repository_portion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /repository_portions/1
  # PUT /repository_portions/1.json
  def update
    @repository_portion = RepositoryPortion.find(params[:id])

    respond_to do |format|
      if @repository_portion.update_attributes(params[:repository_portion])
        format.html { redirect_to @repository_portion, notice: 'Repository portion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repository_portion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repository_portions/1
  # DELETE /repository_portions/1.json
  def destroy
    @repository_portion = RepositoryPortion.find(params[:id])
    @repository_portion.destroy

    respond_to do |format|
      format.html { redirect_to repository_portions_url }
      format.json { head :no_content }
    end
  end
end
