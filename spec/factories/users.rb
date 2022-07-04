FactoryBot.define do

  factory :user do
    name  { "a" * 10 } 
    sequence(:email) { |n| "test#{n}@example.com"}
    password  {"password"} 
  end

end