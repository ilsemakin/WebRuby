# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'сортировка по метражу' do
    visit('/')
    click_on('Список квартир')
    click_on('По метражу')
    expect(page).to have_content('Список квартир')
  end

  it 'сортировка по району' do
    visit('/')
    click_on('Список квартир')
    click_on('По району')
    expect(page).to have_content('Список квартир')
  end

  it 'сортировка по стоимости' do
    visit('/')
    click_on('Список квартир')
    click_on('По стоимости')
    expect(page).to have_content('Список квартир')
  end
end
