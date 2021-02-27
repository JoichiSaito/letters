FactoryBot.define do
  factory :board_1, class: Board do
    title '懇談会のお知らせ'
    content '懇談会のお知らせ'
    questionnaire true
  end

  factory :board_2, class: Board do
    title 'PCR検査を受けられた方へのお知らせ'
    content 'PCR検査を受けられた方へのお知らせ'
    questionnaire false
  end
end
