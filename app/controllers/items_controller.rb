class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    if @item.user_id == current_user.id
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name,
      :introduction, :category_id,
      :condition_id, :delivery_charge_id,
      :region_id, :delivery_days_id, :price
    ).merge(user_id: current_user.id)
  end
end
