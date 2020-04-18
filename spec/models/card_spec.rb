require 'rails_helper'

describe Card do
  describe '#create' do
    context 'can save' do
      it "customer_id, card_id, user_id,が存在すれば登録できる" do
        expect(build(:card)).to be_valid
      end
    end

    context 'can not save' do
      it "customer_idが存在しないと登録できない" do
        card = build(:card, customer_id: nil)
        card.valid?
        expect(card.errors[:customer_id]).to include("を入力してください")
      end
      it "card_idが存在しないと登録できない" do
        card = build(:card, card_id: nil)
        card.valid?
        expect(card.errors[:card_id]).to include("を入力してください")
      end
      it "user_idが存在しないと登録できない" do
        card = build(:card, user_id: nil)
        card.valid?
        expect(card.errors[:user_id]).to include("を入力してください")
      end
    end
  end
end
