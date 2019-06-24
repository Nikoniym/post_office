class ParcelListsController < ApplicationController
  def index
    @parcel_list = ParcelList.new
  end

  def create
    ImportData.from_xml(File.read(params[:parcel_list][:file].tempfile))

    redirect_to parcel_lists_path
  end
end
