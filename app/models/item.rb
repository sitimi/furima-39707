class Item < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :region
  belongs_to :until

  validates :image, presence: true, blob: { content_type: :image }
  validates :name, :introduction, presence: true
  validates :category_id, :condition_id, :delivery_charge_id, :region_id, :delivery_days_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :price, numericality: { in: 300..9999999 }, format: { with: /\A[0-9]+\z/ }, presence: true


end
