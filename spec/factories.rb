FactoryGirl.define do
  factory :user do
    username "example"
    email    "example@example.com"
  end

  factory :post do
    content File.read('spec/post_data/1.mdown')
    user
  end
end