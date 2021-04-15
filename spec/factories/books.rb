FactoryBot.define do
  factory :book do
    title  {'お金の大学'}
    review {Faker::Lorem.sentence}
    association :user

    after(:build) do |book|
      book.image.attach(io: File.open('public/images/output-image.png'), filename: 'output-image.png')
    end
  end
end

