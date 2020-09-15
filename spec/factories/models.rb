FactoryBot.define do
  factory :model do
    id { "" }
    name { "MyString" }
    manufacturer { nil }
    year_of_manufacture { "2020-09-15 14:41:29" }
    delete_flag { false }
  end
end
