require 'rails_helper'

describe ItemImg do
  describe '#create' do

    context 'can save' do
      it "is valid with src, item_id" do
        expect(build(:item_img)).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without src" do
        item_img = build(:item_img, src: nil)
        item_img.valid?
        expect(item_img.errors[:src]).to include("can't be blank")
      end

      it "is invalid without item_id" do
        item_img = build(:item_img, item_id: nil)
        item_img.valid?
        expect(item_img.errors[:item_id]).to include("can't be blank")
      end
    end
  end
end