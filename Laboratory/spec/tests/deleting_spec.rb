# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'удаление' do
    visit('/')
    click_on('Список квартир')

    expect(page).to have_content('Список квартир')
    click_on('По метражу')

    apartment = find_by_id('apartment', match: :first).text
    find_button('Удалить', match: :first).click

    expect(page).to have_content('Список квартир')
    expect(page).not_to have_content(include(apartment))
  end
end
