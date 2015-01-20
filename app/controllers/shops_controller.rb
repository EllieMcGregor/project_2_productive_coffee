class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
  
    @facilities = Facility.all

    @q = Shop.search(params[:q])

    if params[:q]
      @shops = @q.result(distinct: true).includes(:facilities).page(params[:page])
    else
      @shops = Shop.order(:updated_at).page(params[:page])
    end
    
    @hash = Gmaps4rails.build_markers(@shops) do |shop, marker|
      marker.infowindow render_to_string(partial: "shop_for_index", locals: { shop: shop})
      marker.lat shop.latitude
      marker.lng shop.longitude
    end

    if request.xhr?
      render partial: 'shop_for_index', collection: @shops, as: :shop
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
    params.require(:shop).permit(:name, :email, :phone, :user_id, :latitude, :longitude, :street, :city, :postcode, :country)
  end
end
