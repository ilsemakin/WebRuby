# frozen_string_literal: true

RSpec.describe 'Application', type: :feature do
  before do
    Capybara.app = Sinatra::Application.new
  end

  it 'Should greet people' do
    expect('Hello').to eq('Hello')
  end

  it 'Should provide text when connecting to /' do
    visit '/'
    expect(page).to have_content('тестовое приложение')
  end
end
