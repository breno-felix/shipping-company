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
    first_carrier = Carrier.create!(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
                     registration_number: '18519324000104', full_address: 'Rua Valdir Dantas, 440',
                     city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
                     status: 'enabled')
    second_carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    third_carrier = Carrier.create!(corporate_name: 'LT LOG LTDA', brand_name: 'LT LOG', 
                     registration_number: '16443956000106', full_address: 'Rua Capitão Gaspar Soares, 237',
                     city: 'Nova Iguaçu', state: 'RJ', email_domain: 'ltlog.com.br',
                     status: 'disabled')
    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 0, final_weight: 3, price_km: 50,
                  carrier: second_carrier)
    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 3, final_weight: 6, price_km: 65,
                  carrier: second_carrier)
    Price.create!(initial_volume: 1, final_volume: 2, initial_weight: 0, final_weight: 3, price_km: 60,
                  carrier: second_carrier)
    Price.create!(initial_volume: 1, final_volume: 2, initial_weight: 3, final_weight: 6, price_km: 75,
                  carrier: second_carrier)
    Kilometer.create!(initial_kilometer: 0, final_kilometer: 100, price_km: 5000, carrier: second_carrier)
    Kilometer.create!(initial_kilometer: 100, final_kilometer: 200, price_km: 8000, carrier: second_carrier)
    Deadline.create!(initial_kilometer: 0, final_kilometer: 100, deadline: 1, carrier: second_carrier)
    Deadline.create!(initial_kilometer: 100, final_kilometer: 200, deadline: 2, carrier: second_carrier)

    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 0, final_weight: 3, price_km: 50,
      carrier: first_carrier)
    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 3, final_weight: 6, price_km: 65,
      carrier: first_carrier)
    Price.create!(initial_volume: 1, final_volume: 2, initial_weight: 0, final_weight: 3, price_km: 60,
      carrier: first_carrier)
    Price.create!(initial_volume: 1, final_volume: 2, initial_weight: 3, final_weight: 6, price_km: 75,
      carrier: first_carrier)
    Kilometer.create!(initial_kilometer: 0, final_kilometer: 100, price_km: 5000, carrier: first_carrier)
    Kilometer.create!(initial_kilometer: 100, final_kilometer: 200, price_km: 7000, carrier: first_carrier)
    Deadline.create!(initial_kilometer: 0, final_kilometer: 100, deadline: 3, carrier: first_carrier)
    Deadline.create!(initial_kilometer: 100, final_kilometer: 200, deadline: 4, carrier: first_carrier)

    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 0, final_weight: 3, price_km: 50,
                  carrier: third_carrier)
    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 3, final_weight: 6, price_km: 65,
                  carrier: third_carrier)
    Price.create!(initial_volume: 1, final_volume: 2, initial_weight: 0, final_weight: 3, price_km: 60,
                  carrier: third_carrier)
    Price.create!(initial_volume: 1, final_volume: 2, initial_weight: 3, final_weight: 6, price_km: 75,
                  carrier: third_carrier)
    Kilometer.create!(initial_kilometer: 0, final_kilometer: 100, price_km: 5000, carrier: third_carrier)
    Kilometer.create!(initial_kilometer: 100, final_kilometer: 200, price_km: 9000, carrier: third_carrier)
    Deadline.create!(initial_kilometer: 0, final_kilometer: 100, deadline: 1, carrier: third_carrier)
    Deadline.create!(initial_kilometer: 100, final_kilometer: 200, deadline: 3, carrier: third_carrier)
    # Act
    visit root_path
    click_on 'Fazer Orçamento'
    fill_in 'Altura do Item', with: '1'
    fill_in 'Largura do Item', with: '1'
    fill_in 'Profundidade do Item', with: '1'
    fill_in 'Peso do Item', with: '2'
    fill_in 'Distância', with: '150'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('2 resultados encontrados para:')
    expect(page).to have_content('Orçamento para frete de 150Km de distância com item de 1m² e 2Kg')   
    expect(page).to have_content('Valor: 8000')
    expect(page).to have_content('Prazo: 2')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Sede: Cachoeirinha - RS')
    expect(page).to have_content('Documento: 19950592000130')
    expect(page).to have_content('Valor: 7500')
    expect(page).to have_content('Prazo: 4')
    expect(page).to have_link('R2 Logistica', href: carrier_path(Carrier.find_by(brand_name: 'R2 Logistica')))
    expect(page).to have_content('Sede: Fortaleza - CE')
    expect(page).to have_content('Documento: 18519324000104')
    expect(page).to have_link('Criar Ordem de Serviço', count:2)
    expect(page).not_to have_content('Valor: 9000')
    expect(page).not_to have_content('Prazo: 3')
    expect(page).not_to have_link('LT LOG', href: carrier_path(Carrier.find_by(brand_name: 'LT LOG')))
    expect(page).not_to have_content('Sede: Nova Iguaçu - RJ')
    expect(page).not_to have_content('Documento: 16443956000106')
  end
end