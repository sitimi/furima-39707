class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :region, :city, :street, :building_name, :phone_number, :order_id
end

with_options presence: true do
  validates :item_id, :user_id, :order_id
  validates :city, :street
  validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :phone_number, format: { with: /\A[0-9]{11}\z/, message: 'is invalid' }
  validates :region, numericality: {other_than: 0, message: "can't be blank"}
end

def save
  order = Order.create(item_id: item_id, user_id: user_id)
  addresses = Addresses.create( post_code: post_code, region_id: region_id, city: city, street: street,
                                building_name: building_name,phone_number: phone_number, order_id: order)
end