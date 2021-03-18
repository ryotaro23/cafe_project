FactoryBot.define do
  factory :event do
    name { Faker::Lorem.characters(number: 10) }
    time_id {1}
    recommend_menu { Faker::Lorem.characters(number: 10) }
    place {Faker::Lorem.characters(number: 10) }
    max_num {Faker::Number.within(range: 3..9)}
    after(:build) do |event|
      # carrierwaveの場合
      # item.images << build(:event)
      # ActiveStorageの場合
      event.image.attach(io: File.open('spec/fixtures/afternoon.jpg'), filename: 'afternoon.jpg', content_type: 'image/jpg')
    end
  end
end


# require 'faker'
# puts Faker::Number.within(range: 3..9)  #=> loremな文章