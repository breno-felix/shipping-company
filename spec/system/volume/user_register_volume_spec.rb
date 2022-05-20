require 'rails_helper'

describe 'Usuário cadastra preços para volume' do
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
    click_on 'Volume'
    #fill_in 'Volume Inicial', with: ''
    fill_in 'Volume Final', with: '1'
    fill_in 'Valor por Km', with: '20'
    click_on 'Cadastrar'
    #fill_in 'Volume Inicial', with: ''
    fill_in 'Volume Final', with: '3'
    fill_in 'Valor por Km', with: '35'
    click_on 'Cadastrar'
    # Assert
    expect(current_path).to eq new_carrier_volume_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).to have_content('Tabela de preços por intervalos de volume')
    expect(page).to have_content('Volume Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('2')
    expect(page).to have_content('Volume Final')
    expect(page).to have_content('1')
    expect(page).to have_content('3')
    expect(page).to have_content('Valor por Km')
    expect(page).to have_content('20')
    expect(page).to have_content('35')
  end

  
end