# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'добавление' do
    visit('/')
    click_on('Добавление квартиры')
    fill_in('district', with: 'test_d')
    fill_in('street', with: 'test_s')
    fill_in('house', with: 123_456)
    fill_in('footage', with: 2)
    fill_in('rooms', with: 1)
    fill_in('floor', with: 1)
    fill_in('number_of_floors', with: 1)
    fill_in('cost', with: 1)

    fill_in('range_footage_first', with: 1)
    fill_in('range_footage_end', with: 1)
    fill_in('range_rooms_first', with: 1)
    fill_in('range_rooms_end', with: 1)
    fill_in('list_districts', with: 'test_list_district')
    fill_in('list_floors', with: '123')
    fill_in('range_cost_first', with: 1)
    fill_in('range_cost_end', with: 1)

    click_on('Добавить квартиру')

    expect(page).to have_content('test_d')
    expect(page).to have_content('test_s')
    expect(page).to have_content('123456')
    expect(page).to have_content('test_list_district')
    expect(page).to have_content('123')
  end
end
