require 'rails_helper'

RSpec.describe User, type: :model do  
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "問題がなければ登録できる" do
       expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nameが空では登録できない" do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英数字の混合である必要があります")
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = "666666"
        @user.password_confirmation = "666666"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英数字の混合である必要があります")
      end
      it 'passwordが全角文字を含むパスワードでは登録できない' do
        @user.password = "パスワードテスト"
        @user.password_confirmation = "パスワードテスト"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英数字の混合である必要があります")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'password'
        @user.password_confirmation = 'pass'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = "testgmail.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "生年月日が空だと登録できない" do
        @user.dob = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Dob can't be blank")
      end
      it " お名前(全角)は、名字がないと登録できない" do
        @user.last_name_cn =''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name cn は全角ひらがな、全角カタカナ、漢字で入力して下さい", "Last name cn can't be blank")
      end
      it " お名前(全角)は、名前がないと登録できない" do
        @user.first_name_cn = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name cn は全角ひらがな、全角カタカナ、漢字で入力して下さい", "First name cn can't be blank")
      end
      it "お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力でないと登録できない" do
        @user.last_name_cn = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name cn は全角ひらがな、全角カタカナ、漢字で入力して下さい")
      end
      it "お名前カナ(全角)は、名字がないと登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角カタカナで入力して下さい", "Last name kana can't be blank")
      end
      it "お名前カナ(全角)は、名前がないと登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カタカナで入力して下さい", "First name kana can't be blank")
      end
      it "お名前カナ(全角)は、全角（カタカナ）での入力でないと登録できない" do
        @user.first_name_kana = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カタカナで入力して下さい")
      end
    end
  end
end
