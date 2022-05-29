require 'rails_helper'

describe 'Usuário vê detalhes da transportadora' do
  it 'a partir da tela inicial' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    # Assert
    
    expect(page).to have_link('Preços', href: carrier_prices_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_link('Prazo', href: carrier_deadlines_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_link('Veículos', href: carrier_vehicles_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_link('Ordens de Serviço', href: carrier_update_order_services_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Transportadora RV Express')
    expect(page).to have_content('RV Express LTDA')
    expect(page).to have_content('Documento: 19950592000130')
    expect(page).to have_content('Endereço: Rua Áustria, 375 - Cachoeirinha - RS')
    expect(page).to have_content('Status: Ativada')
    expect(page).to have_button('Desativar')
  end

  it 'e desativa transportadora por um botão' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Desativar'
    # Assert
    expect(page).to have_content('Status: Desativada')

  end

  it 'e ativa transportadora por um botão' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'disabled')
    # Act
    visit carrier_path(Carrier.find_by(brand_name: 'RV Express'))
    click_on 'Ativar'
    # Assert
    expect(page).to have_content('Status: Ativada')
  end
end