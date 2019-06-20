# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'поиск соседей по обмену' do
    visit('/')
    click_on('Список квартир')
    
    find_button('Найти соседей по обмену', match: :first).click
    expect(page).to have_content('Обмен')

    swap = find_by_id('swap', match: :first).text

    find_button('Выбрать', match: :first).click
    expect(page).to have_content('Список квартир')
    expect(page).not_to have_content(include(swap))
  end
end
