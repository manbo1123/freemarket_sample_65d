require 'rails_helper'

describe Item do
  describe '#create' do

    context 'can save' do
      it "is valid with name, introduction, price, prefecture_code, trading_status, category_id, brand_id, item_condition_id, postage_payer_id, size_id, preparation_day_id, postage_type_id, seller_id, buyer_id" do
        expect(build(:item)).to be_valid
      end

      it "is valid without brand_id" do
        expect(build(:item, brand_id: nil)).to be_valid
      end

      it "is valid without buyer_id" do
        expect(build(:item, buyer_id: nil)).to be_valid
      end

      it "is valid with all propeties and name(40 characters)" do
        expect(build(:item, name: Faker::Lorem.characters(40))).to be_valid
      end

      it "is valid with all propeties and introduction(1000 characters)" do
        expect(build(:item, introduction: Faker::Lorem.characters(1000))).to be_valid
      end

      it "is valid with all propeties and price(300)" do
        expect(build(:item, price: 300)).to be_valid
      end

      it "is valid with all propeties and price(9999999)" do
        expect(build(:item, price: 9999999)).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without name" do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end

      it "is invalid without introduction" do
        item = build(:item, introduction: nil)
        item.valid?
        expect(item.errors[:introduction]).to include("can't be blank")
      end

      it "is invalid without price" do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("can't be blank")
      end

      it "is invalid without prefecture_code" do
        item = build(:item, prefecture_code: nil)
        item.valid?
        expect(item.errors[:prefecture_code]).to include("can't be blank")
      end

      it "is invalid without trading_status" do
        item = build(:item, trading_status: nil)
        item.valid?
        expect(item.errors[:trading_status]).to include("can't be blank")
      end

      it "is invalid without category_id" do
        item = build(:item, category_id: nil)
        item.valid?
        expect(item.errors[:category_id]).to include("can't be blank")
      end

      it "is invalid without item_condition_id" do
        item = build(:item, item_condition_id: nil)
        item.valid?
        expect(item.errors[:item_condition_id]).to include("can't be blank")
      end

      it "is invalid without postage_payer_id" do
        item = build(:item, postage_payer_id: nil)
        item.valid?
        expect(item.errors[:postage_payer_id]).to include("can't be blank")
      end

      it "is invalid without size_id" do
        item = build(:item, size_id: nil)
        item.valid?
        expect(item.errors[:size_id]).to include("can't be blank")
      end

      it "is invalid without preparation_day_id" do
        item = build(:item, preparation_day_id: nil)
        item.valid?
        expect(item.errors[:preparation_day_id]).to include("can't be blank")
      end

      it "is invalid without postage_type_id" do
        item = build(:item, postage_type_id: nil)
        item.valid?
        expect(item.errors[:postage_type_id]).to include("can't be blank")
      end

      it "is invalid without seller_id" do
        item = build(:item, seller_id: nil)
        item.valid?
        expect(item.errors[:seller_id]).to include("can't be blank")
      end

      it "is invalid with name(41 characters)" do
        item = build(:item, name: Faker::Lorem.characters(41))
        item.valid?
        expect(item.errors[:name]).to include("enter no more than 40 characters")
      end

      it "is invalid with introduction(10001 characters)" do
        item = build(:item, introduction: Faker::Lorem.characters(1001))
        item.valid?
        expect(item.errors[:introduction]).to include("enter less than 1000 characters")
      end

      it "is invalid with price(299)" do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include("enter a price between 300 and 9,999,999")
      end

      it "is invalid with price(10000000)" do
        item = build(:item, price: 10000000)
        item.valid?
        expect(item.errors[:price]).to include("enter a price between 300 and 9,999,999")
      end

    end
  end
end

