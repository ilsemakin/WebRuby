# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'ошибка при добавлении' do
    visit('/')
    click_on('Добавление квартиры')
    click_on('Добавить квартиру')
    expect(page).to have_content('String is empty!')
    expect(page).to have_content('Input a positive number!')
    expect(page).to have_content('Check range!')
  end
end
