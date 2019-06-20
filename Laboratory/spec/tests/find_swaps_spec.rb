# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'поиск всех обменов' do
    visit('/')
    click_on('Список квартир')
    find_button('Найти все обмены', match: :first).click
    expect(page).to have_content('Обмен')
    find_button('Выбрать', match: :first).click
    expect(page).to have_content('Список квартир')
  end

  it 'поиск соседей по обмену' do
    visit('/')
    click_on('Список квартир')
    find_button('Найти соседей по обмену', match: :first).click
    expect(page).to have_content('Обмен')
    find_button('Выбрать', match: :first).click
    expect(page).to have_content('Список квартир')
  end
end
