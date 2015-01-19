class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @shops = Shop.all
    respond_with(@shops)
  end

  def show
    respond_with(@shop)
  end

  def new
    @shop = Shop.new
    respond_with(@shop)
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
