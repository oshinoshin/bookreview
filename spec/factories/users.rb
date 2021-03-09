FactoryBot.define do
  factory :user do
    name                  {'shinya'}
    email                 {Faker::Internet.free_email}
    password              {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    profile               {'test'}
  end
end