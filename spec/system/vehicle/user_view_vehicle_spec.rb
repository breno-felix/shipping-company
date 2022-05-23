require 'rails_helper'

describe 'Usuário visita tela de veículos da Transportadora' do
  it 'e vê o nome da app e menu' do
    #Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Veículos'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_link('Cadastrar Veículo', href: new_carrier_vehicle_path(Carrier.find_by(brand_name: 'RV Express')))
  end

  it 'e vê os veículos cadastrados' do
    #Arrange (cadastrar 2 galpões: Rio e Maceio)
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                    capacity: '35000', carrier: carrier)
   
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Veículos'

    # Asserts
    expect(page).not_to have_content('Não existem transportadoras cadastradas')
    expect(page).to have_content('Lista de Veículos')
    expect(page).to have_content('Volvo VM 270 - 2021')
    expect(page).to have_content('Placa: LSN4I49')
    expect(page).to have_content('Capacidade: 35000 Kg')
  end

  it 'e não existem veículos cadastrados' do
    #Arrange 
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit(root_path)
    click_on 'RV Express'
    click_on 'Veículos'
    
    # Assert
    expect(page).to have_content('Não existem veículos cadastradas')
  end
end