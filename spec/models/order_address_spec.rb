require 'rails_helper'

RSpec.describe OrderAddress, type: :model do

 
  describe '配送先情報の保存' do

    before do
      user = FactoryBot.create(:user)
      @order_address = FactoryBot.build(:order_address, user_id: user.id)
    end
  
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @order_address.user_id = 1
        expect(@order_address).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_address.item_id = 1
        expect(@order_address).to be_valid
      end
      it '郵便番号が「3桁+ハイフン+4桁」の組み合わせであれば保存できる' do
        @order_address.post_code = '123-4567'
        expect(@order_address).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @order_address.region_id = 1
        expect(@order_address).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @order_address.city = '香川県高松市'
        expect(@order_address).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @order_address.street = '2501-1'
        expect(@order_address).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_address.building_name = nil
        expect(@order_address).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @order_address.phone_number = 12_345_678_910
        expect(@order_address).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @order_address.post_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank", 'Post code is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @order_address.post_code = 1234567
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @order_address.region_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Region can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @order_address.region_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Region can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_address.street = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order_address.phone_number = '123-456-7890'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @order_address.phone_number = '1234567890123'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
