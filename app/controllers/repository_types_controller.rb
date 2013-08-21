class RepositoryTypesController < ApplicationController
  # GET /repository_types
  # GET /repository_types.json
  def index
    @repository_types = RepositoryType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repository_types }
    end
  end

  # GET /repository_types/1
  # GET /repository_types/1.json
  def show
    @repository_type = RepositoryType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repository_type }
    end
  end

  # GET /repository_types/new
  # GET /repository_types/new.json
  def new
    @repository_type = RepositoryType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repository_type }
    end
  end

  # GET /repository_types/1/edit
  def edit
    @repository_type = RepositoryType.find(params[:id])
  end

  # POST /repository_types
  # POST /repository_types.json
  def create
    @repository_type = RepositoryType.new(params[:repository_type])

    respond_to do |format|
      if @repository_type.save
        format.html { redirect_to @repository_type, notice: 'Repository type was successfully created.' }
        format.json { render json: @repository_type, status: :created, location: @repository_type }
      else
        format.html { render action: "new" }
        format.json { render json: @repository_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /repository_types/1
  # PUT /repository_types/1.json
  def update
    @repository_type = RepositoryType.find(params[:id])

    respond_to do |format|
      if @repository_type.update_attributes(params[:repository_type])
        format.html { redirect_to @repository_type, notice: 'Repository type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repository_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repository_types/1
  # DELETE /repository_types/1.json
  def destroy
    @repository_type = RepositoryType.find(params[:id])
    @repository_type.destroy

    respond_to do |format|
      format.html { redirect_to repository_types_url }
      format.json { head :no_content }
    end
  end
end
