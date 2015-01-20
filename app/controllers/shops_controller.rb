class ShopsController < ApplicationController
  before_action :set_shop, :clear_search_index, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @shops = Shop.all
    @q = Shop.search(params[:q])
    @shops = @q.result(distinct: true)
    respond_with(@shops)
  end

  def clear_search_index
    if params[:search_cancel]
        params.delete(:search_cancel)
        if(!search_params.nil?)
          search_params.each do |key, param|
            search_params[key] = nil
          end
        end
      end
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
