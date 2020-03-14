require 'rails_helper'
describe SendingDestination do
  describe '#create' do
    #必要な情報が存在すると保存できる
    it "is valid with a destination_family_name, destination_first_name, destination_family_name_kana, destination_first_name_kana, post_code, prefecture_id, city, house_number" do
      sending_destination = build(:sending_destination)
      expect(sending_destination).to be_valid
    end
    #destination_family_nameが空では登録できない
    it "is invalid without a destination_family_name" do
      sending_destination = build(:sending_destination, destination_family_name: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:destination_family_name]).to include("can't be blank")
    end
    #destination_first_nameが空では登録できない
    it "is invalid without a destination_first_name" do
      sending_destination = build(:sending_destination, destination_first_name: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:destination_first_name]).to include("can't be blank")
    end
    #destination_family_name_kanaが空では登録できない
    it "is invalid without a destination_family_name_kana" do
      sending_destination = build(:sending_destination, destination_family_name_kana: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:destination_family_name_kana]).to include("can't be blank")
    end
    #destination_family_name_kanaが空では登録できない
    it "is invalid without a destination_first_name_kana" do
      sending_destination = build(:sending_destination, destination_first_name_kana: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:destination_first_name_kana]).to include("can't be blank")
    end
    #post_codeが空では登録できない
    it "is invalid without a post_code" do
      sending_destination = build(:sending_destination, post_code: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:post_code]).to include("can't be blank")
    end
    #prefecture_idが空では登録できない
    it "is invalid without a prefecture_id" do
      sending_destination = build(:sending_destination, prefecture_id: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:prefecture_id]).to include("can't be blank")
    end
    #cityが空では登録できない
    it "is invalid without a city" do
      sending_destination = build(:sending_destination, city: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:city]).to include("can't be blank")
    end
    #house_numberが空では登録できない
    it "is invalid without a city" do
      sending_destination = build(:sending_destination, house_number: nil)
      sending_destination.valid?
      expect(sending_destination.errors[:house_number]).to include("can't be blank")
    end
  end
end