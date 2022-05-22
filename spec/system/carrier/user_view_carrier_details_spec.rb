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
    expect(page).to have_content('Transportadora RV Express')
    expect(page).to have_content('RV Express LTDA')
    expect(page).to have_content('Documento: 19950592000130')
    expect(page).to have_content('Endereço: Rua Áustria, 375 - Cachoeirinha - RS')
  end
end