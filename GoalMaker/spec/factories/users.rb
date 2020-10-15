FactoryBot.define do
  factory :user do
    username {  Faker::Name.name }
    password { "MyString" }
  end
end
