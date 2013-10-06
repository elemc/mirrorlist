class BuildMirrorsController < ApplicationController
  load_and_authorize_resource
  check_authorization

  # GET /build_mirrors
  # GET /build_mirrors.json
  def index
    @build_mirrors = BuildMirror.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @build_mirrors }
    end
  end

  # GET /build_mirrors/1
  # GET /build_mirrors/1.json
  def show
    @build_mirror = BuildMirror.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @build_mirror }
    end
  end

  # GET /build_mirrors/new
  # GET /build_mirrors/new.json
  def new
    @build_mirror = BuildMirror.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @build_mirror }
    end
  end

  # GET /build_mirrors/1/edit
  def edit
    @build_mirror = BuildMirror.find(params[:id])
  end

  # POST /build_mirrors
  # POST /build_mirrors.json
  def create
    @build_mirror = BuildMirror.new(params[:build_mirror])

    respond_to do |format|
      if @build_mirror.save
        format.html { redirect_to @build_mirror, notice: 'Build mirror was successfully created.' }
        format.json { render json: @build_mirror, status: :created, location: @build_mirror }
      else
        format.html { render action: "new" }
        format.json { render json: @build_mirror.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /build_mirrors/1
  # PUT /build_mirrors/1.json
  def update
    @build_mirror = BuildMirror.find(params[:id])

    respond_to do |format|
      if @build_mirror.update_attributes(params[:build_mirror])
        format.html { redirect_to @build_mirror, notice: 'Build mirror was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @build_mirror.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_mirrors/1
  # DELETE /build_mirrors/1.json
  def destroy
    @build_mirror = BuildMirror.find(params[:id])
    @build_mirror.destroy

    respond_to do |format|
      format.html { redirect_to build_mirrors_url }
      format.json { head :no_content }
    end
  end
end
