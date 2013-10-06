class MirrorsController < ApplicationController
  load_and_authorize_resource
  check_authorization
  helper_method :our_mirror?

  # GET /mirrors
  # GET /mirrors.json
  def index
    @mirrors = Mirror.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mirrors }
    end
  end

  # GET /mirrors/1
  # GET /mirrors/1.json
  def show
    @mirror = Mirror.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mirror }
    end
  end

  # GET /mirrors/new
  # GET /mirrors/new.json
  def new
    @mirror = Mirror.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mirror }
    end
  end

  # GET /mirrors/1/edit
  def edit
    @mirror = Mirror.find(params[:id])
  end

  # POST /mirrors
  # POST /mirrors.json
  def create
    @mirror = Mirror.new(params[:mirror])
    @mirror.user_id = current_user.id

    respond_to do |format|
      if @mirror.save
        format.html { redirect_to @mirror, notice: 'Mirror was successfully created.' }
        format.json { render json: @mirror, status: :created, location: @mirror }
      else
        format.html { render action: "new" }
        format.json { render json: @mirror.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mirrors/1
  # PUT /mirrors/1.json
  def update
    @mirror = Mirror.find(params[:id])

    respond_to do |format|
      if @mirror.update_attributes(params[:mirror])
        format.html { redirect_to @mirror, notice: 'Mirror was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mirror.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mirrors/1
  # DELETE /mirrors/1.json
  def destroy
    @mirror = Mirror.find(params[:id])
    @mirror.destroy

    respond_to do |format|
      format.html { redirect_to mirrors_url }
      format.json { head :no_content }
    end
  end

  def enable
    @mirror = Mirror.find(params[:id])
    @mirror.enabled = true
    respond_to do |format|
      if @mirror.save
        format.html { redirect_to mirrors_url, notice: 'Mirror was successfully enabled.' }
        format.json { render json: @mirror, status: :created, location: @mirror }
      else
        format.html { redirect_to mirrors_url, error: 'Mirror enabled fail!' }
        format.json { render json: @mirror.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @mirror = Mirror.find(params[:id])
    @mirror.enabled = false
    respond_to do |format|
      if @mirror.save
        format.html { redirect_to mirrors_url, notice: 'Mirror was successfully disabled.' }
        format.json { render json: @mirror, status: :created, location: @mirror }
      else
        format.html { redirect_to mirrors_url, error: 'Mirror disabled fail!' }
        format.json { render json: @mirror.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def our_mirror?( mirror, user )
    if user.role.downcase == 'admin'
        return true
    end

    return true if mirror.user_id == user.id
    false
  end

end
