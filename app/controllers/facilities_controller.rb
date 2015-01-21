class FacilitiesController < ApplicationController


  def show
    respond_with(@facility)
  end

  def new
    @facility = Facility.new
    respond_with(@facility)
  end

  def edit
  end

  def create
  end


  def destroy
    @facility.destroy
    respond_with(@facility)
  end

  private
  def set_facility
    @facility = Facility.find(params[:id])
  end

  def facility_params
    params.require(:facility).permit(:name, :facility_image, :remote_facility_image_url)
  end
end
