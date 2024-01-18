class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :region_id, :city, :street, :building_name, :phone_number, :order_id, :token

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :city
    validates :street
    validates :region_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は無効です。ハイフン(-)を含めて入力してください' }
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'は無効です' }
  end

  def save
    order = Order.create(item_id:, user_id:)
    Address.create(post_code:, region_id:, city:, street:,
                   building_name:, phone_number:, order_id: order.id)
  end
end
