class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :image, :name,
      :introduction, :category_id,
      :condition_id, :delivery_charge_id,
      :region_id, :until_id, :price
    ).merge(user_id: current_user.id)
  end

end
