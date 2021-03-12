FactoryBot.define do
  factory :event do
    name { Faker::Lorem.characters(number: 10) }
    time_id {1}
    recommend_menu { Faker::Lorem.characters(number: 10) }
    place {Faker::Lorem.characters(number: 10) }
    max_num {Faker::Number.within(range: 3..9)}
  end
end


# require 'faker'
# puts Faker::Number.within(range: 3..9)  #=> loremな文章