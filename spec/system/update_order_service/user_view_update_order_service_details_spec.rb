require 'rails_helper'

describe 'Usuário vê detalhes das Ordens de Serviço' do
  it 'a partir da tela inicial' do
   #Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Ordens de Serviço'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Ordens de Serviço')
  end

  it 'e vê as Ordens de Serviço cadastradas' do
    # Arrange
      carrier_first = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
      carrier_second = Carrier.create!(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
                      registration_number: '18519324000104', full_address: 'Rua Valdir Dantas, 440',
                      city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
                      status: 'enabled')       
      order_service_first = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', carrier: carrier_first) 
      order_service_second = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', carrier: carrier_second)
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Ordens de Serviço'

    # Asserts
    expect(page).not_to have_content('Não existem Ordens de Serviço cadastradas')
    expect(page).to have_content("Ordem de Serviço #{order_service_first.code}", count: 1)
    expect(page).to have_content('Status: Pendente', count: 1)
    expect(page).to have_content('Frete de 150Km de distância com item de 1m² e 2Kg', count: 1)
    expect(page).to have_content('Valor: 8000', count: 1)
    expect(page).to have_content('Prazo: 2', count: 1)
    expect(page).to have_content('Endereço para Retirada: R. dos Andradas, 1001 - Porto Alegre - RS', count: 1)
    expect(page).to have_content('Código do Produto: ABC123', count: 1) 
    expect(page).to have_content('Endereço para Entrega: R. Luís Augusto Branco, 97 - Ipê - RS', count: 1)
    expect(page).to have_content('Nome do Destinatário: Breno Felix', count: 1) 
    expect(page).to have_content('CPF do Destinatário: 02398746509', count: 1)
  end

  it 'e não existem Ordem de Serviço cadastrada' do
    #Arrange 
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit(root_path)
    click_on 'RV Express'
    click_on 'Ordens de Serviço'
    
    # Assert
    expect(page).to have_content('Não existem Ordens de Serviço cadastradas')
  end

  it 'e aceita a Ordem de Serviço por um botão' do
    # Arrange
      carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')       
      order_service = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', carrier: carrier) 
      Vehicle.create!(brand: 'Ford', model: 'Cargo 1717E', year: '2020', plate: 'LCC9E82',
                    capacity: '27000', carrier: carrier)
      Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                    capacity: '35000', carrier: carrier)
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Ordens de Serviço'
    click_on 'Aceitar'
    select 'Volvo VM 270 - LSN4I49', from: 'Veículo'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('Status: Aceita')
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
  end

  it 'e recusa a Ordem de Serviço por um botão' do
    # Arrange
      carrier_first = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')       
      order_service_first = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', carrier: carrier_first) 
    # Act  
    visit(root_path)
    click_on 'RV Express'
    click_on 'Ordens de Serviço'
    click_on 'Recusar'
    # Assert
    expect(page).to have_content('Status: Recusada')
    expect(page).not_to have_link('Aceitar')
    expect(page).not_to have_link('Recusar')
  end
end