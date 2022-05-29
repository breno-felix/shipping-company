require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app e menu' do
    #Arrange (nesse caso pode ficar vazio, pois é o início)

    # Act
    visit(root_path)
    # Assert
    expect(page).to have_content('Br Transportadoras')
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('Cadastrar Transportadora', href: new_carrier_path)
    expect(page).to have_link('Fazer Orçamento', href: budget_carriers_path )
    expect(page).to have_link('Ordens de Serviço', href: order_services_path )
  end

  it 'e vê as transportadoras cadastradas' do
    #Arrange (cadastrar 2 galpões: Rio e Maceio)
    Carrier.create!(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
                     registration_number: '18519324000104', full_address: 'Rua Valdir Dantas, 440',
                     city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
                     status: 'enabled')
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    Carrier.create!(corporate_name: 'LT LOG LTDA', brand_name: 'LT LOG', 
                     registration_number: '16443956000106', full_address: 'Rua Capitão Gaspar Soares, 237',
                     city: 'Nova Iguaçu', state: 'RJ', email_domain: 'ltlog.com.br',
                     status: 'disabled')
   
    # Act  
    visit(root_path)

    # Asserts
    expect(page).not_to have_content('Não existem transportadoras cadastradas')
    expect(page).to have_link('R2 Logistica', href: carrier_path(Carrier.find_by(brand_name: 'R2 Logistica')))
    expect(page).to have_content('Sede: Fortaleza - CE')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Sede: Cachoeirinha - RS')
    expect(page).not_to have_content('LT LOG')
    expect(page).not_to have_content('Sede: Nova Iguaçu - RJ')
  end

  it 'e não existem transportadoras cadastradas' do
    #Arrange 

    # Act
    visit(root_path)
    
    # Assert
    expect(page).to have_content('Não existem transportadoras cadastradas')
  end
end