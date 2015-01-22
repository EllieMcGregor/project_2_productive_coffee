class ShopsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  respond_to :html

  load_and_authorize_resource

  def index
    @facilities = Facility.all

    @q = Shop.search(params[:q])

    @shops = @q.result(distinct: true).page(params[:page])

    @markers = markers_for_gmaps(@shops)

    if request.xhr?
      shops_list = render_to_string partial: 'shop_list'
      render json: { shops_list: shops_list, markers: @markers }
    else
      respond_with(@shops)
    end
  end 

  def show
    respond_with(@shop)
  end

  def new
    @shop = Shop.new
    respond_with(@shop)
  end

  def edit
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user
    @shop.save
    respond_with(@shop)
  end

  def update
    @shop.update(shop_params)
    respond_with(@shop)
  end

  def destroy
    @shop.destroy
    respond_with(@shop)
  end

  private
  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :email, :phone, :user_id, :latitude, :longitude, :street, :city, :postcode, :country, :shop_image, :remote_shop_image_url)
  end

  def markers_for_gmaps(shops)
    Gmaps4rails.build_markers(shops) do |shop, marker|
      marker.infowindow render_to_string(partial: "shop_infowindow", locals: { shop: shop})
      marker.picture({
        url: "/assets/coffee.png",
        width: 32,
        height: 38
      })
      marker.lat shop.latitude
      marker.lng shop.longitude
    end
  end
end
