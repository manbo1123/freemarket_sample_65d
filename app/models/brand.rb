class Brand < ApplicationRecord
  has_many :items

  #ブランドは別途作成
  #if name.present?
  #  @brand_array = Brand.pluck(:name)
  #  brand = Brand.find_or_create_by!(name: name)
  #  @item.update(brand_id: brand.id)
  #end
end
