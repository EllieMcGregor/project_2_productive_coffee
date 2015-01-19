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

  private
  def set_shop
    @shop = Shop.find(params[:id])
  end
end
