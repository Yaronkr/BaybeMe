class ChildcaresController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @childcares = Childcare.where("address ILIKE ?", "%#{params[:query]}%")
    else
      @childcares = Childcare.all
    end

    @markers = @childcares.geocoded.map do |childcare|
      {
        lat: childcare.latitude,
        lng: childcare.longitude,
        info_window: render_to_string(partial: "info_window", locals: { childcare: childcare }),
        image_url: helpers.asset_url("map2.png")
      }
    end
  end

  def show
    @childcare = Childcare.find(params[:id])
    @markers =[
      {
        lat: @childcare.latitude,
        lng: @childcare.longitude,
        info_window: render_to_string(partial: "info_window", locals: { childcare: @childcare }),
        image_url: helpers.asset_url("map2.png")
      }
    ]
  end

  # def childcare_params
  #   params.require(:childcare).permit(:name, :email, :address, :url, :description, :created_at, :updated_at, :photo)
  # end
end
