FactoryBot.define do
  factory :user_school, class: User do
    name 'レイルズ小学校'
    sequence(:email) { |n| "rails#{n}@example.com" }
    password 'railsshogakko'
    private true
    position 0
  end

  factory :user_school2, class: User do
    name 'ララベル小学校'
    sequence(:email) { |n| "laravel#{n}@example.com" }
    password 'laravelshogakko'
    private false
    position 0
  end

  factory :user_parent, class: User do
    name 'ルビ子'
    email 'ruby@example.com'
    password 'rubyprimarygirl'
    private false
    position 1
  end
end
