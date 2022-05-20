require 'rails_helper'

describe 'Usuário cadastra preços' do
  it 'com sucesso' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Cadastrar Preços'
    #fill_in 'Volume Inicial', with: ''
    fill_in 'Volume Final', with: '1'
    #fill_in 'Peso Inicial', with: ''
    fill_in 'Peso Final', with: '10'
    fill_in 'Valor por Km', with: '50'
    click_on 'Cadastrar'
    click_on 'Cadastrar outro intevalo'
    #fill_in 'Volume Inicial', with: ''
    fill_in 'Volume Final', with: '3'
    #fill_in 'Peso Inicial', with: ''
    fill_in 'Peso Final', with: '20'
    fill_in 'Valor por Km', with: '80'
    click_on 'Cadastrar'
    # Assert
    expect(current_path).to eq carrier_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).to have_content('Tabela de preços por intervalos de volume e peso')
    expect(page).to have_content('Volume Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('2')
    expect(page).to have_content('Volume Final')
    expect(page).to have_content('1')
    expect(page).to have_content('3')
    expect(page).to have_content('Peso Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('11')
    expect(page).to have_content('Peso Final')
    expect(page).to have_content('10')
    expect(page).to have_content('20')
    expect(page).to have_content('Valor por Km')
    expect(page).to have_content('50')
    expect(page).to have_content('80')
  end

  
end