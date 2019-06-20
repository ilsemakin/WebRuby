# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'загрузка файла' do
    visit('/')
    click_on('Список квартир')

    find_button('Найти все обмены', match: :first).click
    expect(page).to have_content('Обмен')

    swap = find_by_id('swap', match: :first).text
    find_button('Выбрать', match: :first).click
    expect(page).to have_content('Список квартир')

    click_on('Скачать выбранные обмены')

    expect(html).to include(swap)
  end
end
