class ItemsController < ApplicationController
  def index
    
  end

  def new
    @item = Item.new
  end

  # ストロングパラメーターにはpermit(:image) を追加すること
end
