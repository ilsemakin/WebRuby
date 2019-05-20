# frozen_string_literal: true

RSpec.describe 'Application', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'Should provide text when connecting to /' do
    visit('/')
    expect(page).to have_content('Оценки')
  end

  it 'Should allow to add new test results' do
    visit('/')
    click_on('Добавить тест')
    fill_in('name', with: 'Математика')
    fill_in('mark', with: 4)
    click_on('Добавить')
    expect(page).to have_content('Математика')
    expect(page).to have_content('4')
  end

  it 'Should show errors about empty input' do
    visit('/')
    click_on('Добавить тест')
    click_on('Добавить')
    expect(page).to have_content('Ошибка!')
  end

  it 'Should allow to edit exisitng mark' do
    visit('/')
    click_on('Редактировать', id: 'edit-mark-1')
    fill_in('name', with: 'Философия')
    fill_in('mark', with: '5')
    click_on('Добавить')
    expect(page).to have_content('Философия')
  end
end
