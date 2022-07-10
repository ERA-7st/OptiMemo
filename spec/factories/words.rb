FactoryBot.define do

  factory :word do
    word { "a" * 20 }
    content { "test" }
  end

end
