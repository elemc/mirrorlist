class RepositoryVariantsController < ApplicationController
  # GET /repository_variants
  # GET /repository_variants.json
  def index
    @repository_variants = RepositoryVariant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repository_variants }
    end
  end

  # GET /repository_variants/1
  # GET /repository_variants/1.json
  def show
    @repository_variant = RepositoryVariant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repository_variant }
    end
  end

  # GET /repository_variants/new
  # GET /repository_variants/new.json
  def new
    @repository_variant = RepositoryVariant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repository_variant }
    end
  end

  # GET /repository_variants/1/edit
  def edit
    @repository_variant = RepositoryVariant.find(params[:id])
  end

  # POST /repository_variants
  # POST /repository_variants.json
  def create
    @repository_variant = RepositoryVariant.new(params[:repository_variant])

    respond_to do |format|
      if @repository_variant.save
        format.html { redirect_to @repository_variant, notice: 'Repository variant was successfully created.' }
        format.json { render json: @repository_variant, status: :created, location: @repository_variant }
      else
        format.html { render action: "new" }
        format.json { render json: @repository_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /repository_variants/1
  # PUT /repository_variants/1.json
  def update
    @repository_variant = RepositoryVariant.find(params[:id])

    respond_to do |format|
      if @repository_variant.update_attributes(params[:repository_variant])
        format.html { redirect_to @repository_variant, notice: 'Repository variant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repository_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repository_variants/1
  # DELETE /repository_variants/1.json
  def destroy
    @repository_variant = RepositoryVariant.find(params[:id])
    @repository_variant.destroy

    respond_to do |format|
      format.html { redirect_to repository_variants_url }
      format.json { head :no_content }
    end
  end
end
