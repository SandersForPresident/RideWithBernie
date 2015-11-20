class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    if @profile.nil?
      render json: {error: 'Unable to find profile with given uuid'}, status: :not_found
    else
      render :show, status: :ok, location: @profile
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      render :show, status: :created, location: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      # Primarily we want to find the user by a uuid...
      # But I think there's definitely a case for finding the user by phone number
      if params[:phone_number]
        @profile = Profile.where(phone: params[:phone_number]).first
      elsif params[:id]
        @profile = Profile.where(uuid: params[:id]).first # where.first is better than find_by_uuid
      else
        @profile = nil
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :driver, :phone, :location, :spots, :plus_ones, :eventId, :eventTitle, :uuid)
    end
end
