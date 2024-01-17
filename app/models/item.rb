class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one    :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :region
  belongs_to :delivery_days

  validates :image, presence: true, blob: { content_type: :image }
  validates :name, :introduction, presence: true
  validates :category_id, :condition_id, :delivery_charge_id, :region_id, :delivery_days_id,
            numericality: { other_than: 1, message: "can't be blank" }
  validates :price, numericality: { only_integer: true, in: 300..9_999_999 }, presence: true
end
