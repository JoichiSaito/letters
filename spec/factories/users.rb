FactoryBot.define do
  factory :user_school, class: User do
    name 'レイルズ小学校'
    email 'rails@example.com'
    password 'railsshogakko'
    private true
    position 0
  end

  factory :user_school2 do
    name 'ララベル小学校'
    email 'laravel@example.com'
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
