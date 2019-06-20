# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'главная страница' do
    visit('/')
    expect(page).to have_content('Информация о приложении')
  end

  it 'список квартир' do
    visit('/')
    click_on('Список квартир')
    expect(page).to have_content('Список квартир')
  end

  it 'квартиры без обмена' do
    visit('/')
    click_on('Квартиры без обмена')
    expect(page).to have_content('Квартиры без вариантов обмена')
  end

  it 'статистика' do
    visit('/')
    click_on('Составление статистики для каждого района')
    expect(page).to have_content('Статистика')
  end

  it 'проверка базы данных' do
    visit('/')
    click_on('Проверка базы данных')
    expect(page).to have_content('Проверка базы данных')
  end

  it 'несуществующая страница' do
    visit('/1234')
    expect(page).to have_content('Страница не существует')
  end
end
