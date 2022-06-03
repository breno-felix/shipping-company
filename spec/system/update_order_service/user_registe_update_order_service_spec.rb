require 'rails_helper'

describe 'Usuário atualiza Ordem de Serviço aceita' do
  it 'a partir do menu e encontra campo para buscar' do
    # Arrange
      carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')   
                      Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                        capacity: '35000', carrier: carrier)    
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Atualizar Ordem de Serviço'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Atualizar Ordem de Serviço')
    expect(page).to have_field('Buscar Ordem de Serviço')
    expect(page).to have_button('Buscar')
  end

  it 'e encontra a ordem de serviço a ser atualizada' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
    vehicle = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                      capacity: '35000', carrier: carrier)
    order_service = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', status: 'accepted', carrier: carrier, vehicle: vehicle) 
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Atualizar Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço', with: order_service.code
    click_on 'Buscar'
    # Assert
    expect(current_path).to eq search_carrier_update_order_services_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).to have_content("Ordem de Serviço #{order_service.code}")
    expect(page).to have_content('Endereço para Retirada: R. dos Andradas, 1001 - Porto Alegre - RS')
    expect(page).to have_content('Endereço para Entrega: R. Luís Augusto Branco, 97 - Ipê - RS')
    expect(page).to have_content('Status: Aceita')
    expect(page).to have_content('Veículo: Volvo VM 270 - LSN4I49')
    expect(page).to have_content('Ordem de Serviço não possui atualizações')
    expect(page).to have_link('Atualizar')
  end

  it 'e encontra campos para atualizar' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
    vehicle = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                      capacity: '35000', carrier: carrier)
    order_service = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', status: 'accepted', carrier: carrier, vehicle: vehicle) 
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Atualizar Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço', with: order_service.code
    click_on 'Buscar'
    click_on 'Atualizar'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content("Atualizar Ordem de Serviço #{order_service.code}")
    expect(page).to have_field('Mensagem de Atualização')
    expect(page).to have_field('Longitude')
    expect(page).to have_field('Latitude')
    expect(page).to have_button('Enviar')
    
  end

  it 'e encontra a ordem de serviço atualizada com sucesso' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
    vehicle = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                      capacity: '35000', carrier: carrier)
    order_service = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', status: 'accepted', carrier: carrier, vehicle: vehicle) 
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Atualizar Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço', with: order_service.code
    click_on 'Buscar'
    click_on 'Atualizar'
    fill_in 'Mensagem de Atualização', with: "Pedido Retirado"
    fill_in 'Latitude', with: "-30"
    fill_in 'Longitude', with: "-51"
    click_on 'Enviar'
    fill_in 'Buscar Ordem de Serviço', with: order_service.code
    click_on 'Buscar'
    # Assert
    expect(current_path).to eq search_carrier_update_order_services_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).to have_content("Ordem de Serviço #{order_service.code}")
    expect(page).to have_content('Endereço para Retirada: R. dos Andradas, 1001 - Porto Alegre - RS')
    expect(page).to have_content('Endereço para Entrega: R. Luís Augusto Branco, 97 - Ipê - RS')
    expect(page).to have_content('Status: Aceita')
    expect(page).to have_content('Veículo: Volvo VM 270 - LSN4I49')
    expect(page).to have_content('Tabela de atualizações da entrega')
    #falta fazer a verificaçao da tabela
    expect(page).to have_link('Atualizar')
    expect(page).to have_button('Finalizar')

  end

  it 'e finaliza a ordem de serviço após atualização' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
    vehicle = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                      capacity: '35000', carrier: carrier)
    order_service = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', status: 'accepted', carrier: carrier, vehicle: vehicle) 
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Atualizar Ordem de Serviço'
    fill_in 'Buscar Ordem de Serviço', with: order_service.code
    click_on 'Buscar'
    click_on 'Atualizar'
    fill_in 'Mensagem de Atualização', with: "Pedido Retirado"
    fill_in 'Latitude', with: "-30"
    fill_in 'Longitude', with: "-51"
    click_on 'Enviar'
    fill_in 'Buscar Ordem de Serviço', with: order_service.code
    click_on 'Buscar'
    click_on 'Finalizar'
    fill_in 'Buscar Ordem de Serviço', with: order_service.code
    click_on 'Buscar'
   # Assert
    expect(current_path).to eq search_carrier_update_order_services_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).to have_content("Ordem de Serviço #{order_service.code}")
    expect(page).to have_content('Endereço para Retirada: R. dos Andradas, 1001 - Porto Alegre - RS')
    expect(page).to have_content('Endereço para Entrega: R. Luís Augusto Branco, 97 - Ipê - RS')
    expect(page).to have_content('Status: Finalizada')
    expect(page).to have_content('Veículo: Volvo VM 270 - LSN4I49')
    expect(page).to have_content('Tabela de atualizações da entrega')
    #falta fazer a verificaçao da tabela
    expect(page).not_to have_link('Atualizar')
    expect(page).not_to have_button('Finalizar')
 end
end