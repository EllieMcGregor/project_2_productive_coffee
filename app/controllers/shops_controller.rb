class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  def index
    @shops = Shop.all
  end
  private
  def set_shop
    @shop = Shop.find(params[:id])
  end
end
