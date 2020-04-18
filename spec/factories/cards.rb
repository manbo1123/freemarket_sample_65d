FactoryBot.define do
  factory :card do
    customer_id {"test_customer_id"}
    card_id     {"test_card_id"}
    user_id     {1}
  end
end
