# frozen_string_literal: true

RSpec.describe 'Обмен квартир :', type: :feature do
  before(:example) do
    Capybara.app = Sinatra::Application.new
  end

  it 'загрузка файла' do
    visit('/')
    click_on('Скачать выбранные обмены')
    expect(html).to have_content('Дзержинский')
    expect(html).to have_content('Петрова')
    expect(html).to have_content('7')
    expect(html).to have_content('80')
    expect(html).to have_content('Панельный')
    expect(html).to have_content('2500500')
  end
end
