require 'rails_helper'

describe 'Usuário busca orçamentos' do
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fazer Orçamento'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_content('Fazer Orçamento')
    expect(page).to have_field('Altura do Item')
    expect(page).to have_field('Largura do Item')
    expect(page).to have_field('Profundidade do Item')
    expect(page).to have_field('Peso do Item')
    expect(page).to have_field('Distância')
    expect(page).to have_button('Enviar')
  end

  it 'e encontra os orçamentos' do
    # Arrange
    Carrier.create!(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
                     registration_number: '18519324000104', full_address: 'Rua Valdir Dantas, 440',
                     city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
                     status: 'enabled')
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')

    # Act

    # Assert


  end
end