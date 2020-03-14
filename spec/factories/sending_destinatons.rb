FactoryBot.define do

  factory :sending_destination do
    destination_family_name         {"山田"}
    destination_first_name          {"太郎"}
    destination_family_name_kana    {"ヤマダ"}
    destination_first_name_kana     {"タロウ"}
    post_code                       {"1112222"}
    prefecture_id                   {"1"}
    city                            {"渋谷区"}
    house_number                    {"１丁目"}
  end

end