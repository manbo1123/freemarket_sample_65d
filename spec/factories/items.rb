FactoryBot.define do
  factory :item do
    name                {"名前"}
    introduction        {"説明文"}
    price               {1000}
    prefecture_code     {1}
    trading_status      {0}
    category_id         {100}
    brand_id            {1}
    item_condition_id   {1}
    postage_payer_id    {1}
    size_id             {1}
    preparation_day_id  {1}
    postage_type_id     {1}
    seller_id           {1}
    buyer_id            {nil}
  end

end