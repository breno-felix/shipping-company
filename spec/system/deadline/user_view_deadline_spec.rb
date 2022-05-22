require 'rails_helper'

describe 'Usuário visita tela de prazos da Transportadora' do
  it 'e vê o nome da app e menu' do
    #Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Prazos'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Cadastrar Prazos por:')
    expect(page).to have_link('Km', href: new_carrier_deadline_path(Carrier.find_by(brand_name: 'RV Express')))
  end

  it 'e vê os prazos por Km cadastrados em uma tabela' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Prazos'
    click_on 'Km'
    fill_in 'Km Final', with: '100'
    fill_in 'Prazo', with: '1'
    click_on 'Cadastrar'
    fill_in 'Km Final', with: '200'
    fill_in 'Prazo', with: '2'
    click_on 'Cadastrar'
    click_on 'RV Express'
    click_on 'Prazos'
    # Assert
    expect(current_path).to eq carrier_deadlines_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).to have_content('Tabela de prazos por intervalos de Km')
    expect(page).to have_content('Km Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('100')
    expect(page).to have_content('Km Final')
    expect(page).to have_content('100')
    expect(page).to have_content('200')
    expect(page).to have_content('Prazo')
    expect(page).to have_content('1')
    expect(page).to have_content('2')
  end
end