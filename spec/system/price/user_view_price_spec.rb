require 'rails_helper'

describe 'Usuário visita tela de preço da Transportadora' do
  it 'e vê o nome da app e menu' do
    #Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Preços'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Cadastrar Preços por:')
    expect(page).to have_link('Volume', href: new_carrier_volume_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_link('Peso', href: new_carrier_weight_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_link('Km', href: new_carrier_kilometer_path(Carrier.find_by(brand_name: 'RV Express')))
  end

  # it 'e vê os preços por volume e peso cadastrados em uma tabela' do
  #   #Arrange (cadastrar 2 Volumes e 2 Pesos)
  #   first_carrier = Carrier.create!(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
  #                    registration_number: '18519324000104', full_address: 'Rua Valdir Dantas, 440',
  #                    city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
  #                    status: 'enabled')
  #   second_carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
  #                    registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
  #                    city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
  #                    status: 'enabled')
  #   first_volume = Volume.create!(initial_volume: 0, final_volume: 1, price_km: 20, carrier_id: second_carrier.id)
  #   second_volume = Volume.create!(initial_volume: 1, final_volume: 2, price_km: 30, carrier_id: second_carrier.id)
  #   first_weight = Weight.create!(initial_weight: 0, final_weight: 10, price_km: 25, carrier_id: second_carrier.id)
  #   second_weight = Weight.create!(initial_weight: 10, final_weight: 20, price_km: 35, carrier_id: second_carrier.id)
  #   # Act  
  #   visit(carrier_prices_path(Carrier.find_by(brand_name: 'RV Express')))

  #   # Asserts
  #   within_table('table') do
  #     click_on 'Modelos de Produtos'
  #   end 

  #   expect(page).to have_content('Tabela de preços por intervalos de volume e peso')
  #   expect(page).to have_content('Volume Inicial')
  #   expect(page).to have_content('0', count: 2)
  #   expect(page).to have_content('1', count: 2)
  #   expect(page).to have_content('Volume Final')
  #   expect(page).to have_content('1', count:2)
  #   expect(page).to have_content('2', count: 2)
  #   expect(page).to have_content('Peso Inicial')
  #   expect(page).to have_content('0', count: 2)
  #   expect(page).to have_content('10', count: 2)
  #   expect(page).to have_content('Peso Final')
  #   expect(page).to have_content('10', count: 2)
  #   expect(page).to have_content('20', count: 2)
  #   expect(page).to have_content('Valor por Km')
  #   expect(page).to have_content('45')
  #   expect(page).to have_content('55')
  #   expect(page).to have_content('55')
  #   expect(page).to have_content('65')
  # end

  # it 'e não existem preços por intervalos de volumes e pesos cadastrados.' do
  #   #Arrange 

  #   # Act
  #   visit(root_path)
    
  #   # Assert
  #   expect(page).to have_content('Não existem transportadoras cadastradas')
  # end

  # it 'e vê os preços por Km cadastrados em uma tabela' do
  # end

  # it 'e não existem preços por intervalos Km cadastrados.' do
  # end
end