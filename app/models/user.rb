class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  validates :name, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は英数字の混合である必要があります' }
  validates :last_name_cn, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は全角ひらがな、全角カタカナ、漢字で入力して下さい' }, presence: true
  validates :first_name_cn, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は全角ひらがな、全角カタカナ、漢字で入力して下さい' }, presence: true
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力して下さい' }, presence: true
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力して下さい' }, presence: true
  validates :dob, presence: true
end
