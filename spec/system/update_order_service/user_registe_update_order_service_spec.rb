require 'rails_helper'

describe 'Usuário atualiza Ordem de Serviço aceita' do
  it 'a partir do menu' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 0, final_weight: 3, price_km: 50,
                  carrier: carrier)  
    Kilometer.create!(initial_kilometer: 100, final_kilometer: 200, price_km: 8000, carrier: carrier)               
    Deadline.create!(initial_kilometer: 100, final_kilometer: 200, deadline: 2, carrier: carrier)
    # Act
    visit root_path
    click_on 'Fazer Orçamento'
    fill_in 'Altura do Item', with: '1'
    fill_in 'Largura do Item', with: '1'
    fill_in 'Profundidade do Item', with: '1'
    fill_in 'Peso do Item', with: '2'
    fill_in 'Distância', with: '150'
    click_on 'Enviar'
    click_on 'Criar Ordem de Serviço'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_content('Criar Ordem de Serviço')
    expect(page).to have_content('Dados para a retirada do produto')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Código do Produto')
    expect(page).to have_content('Dados para a entrega do produto')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_content('Dados do Destinatário')
    expect(page).to have_field('Nome')
    expect(page).to have_field('CPF')
    expect(page).to have_button('Enviar')
  end

  it 'e encontra a ordem de serviço com sucesso' do
     # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 0, final_weight: 3, price_km: 50,
                  carrier: carrier)  
    Kilometer.create!(initial_kilometer: 100, final_kilometer: 200, price_km: 8000, carrier: carrier)               
    Deadline.create!(initial_kilometer: 100, final_kilometer: 200, deadline: 2, carrier: carrier)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD1234EFGH567')
    # Act
    visit root_path
    click_on 'Fazer Orçamento'
    fill_in 'Altura do Item', with: '1'
    fill_in 'Largura do Item', with: '1'
    fill_in 'Profundidade do Item', with: '1'
    fill_in 'Peso do Item', with: '2'
    fill_in 'Distância', with: '150'
    click_on 'Enviar'
    click_on 'Criar Ordem de Serviço'
    within('div#search') do
      fill_in 'Endereço', with: 'R. dos Andradas, 1001'
      fill_in 'Cidade', with: 'Porto Alegre'
      fill_in 'Estado', with: 'RS'
    end
    fill_in 'Código do Produto', with: 'ABC123'
    within('div#delivery') do
      fill_in 'Endereço', with: 'R. Luís Augusto Branco, 97'
      fill_in 'Cidade', with: 'Ipê'
      fill_in 'Estado', with: 'RS'
    end
    fill_in 'Nome', with: 'Breno Felix'
    fill_in 'CPF', with: '02398746509'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq order_services_path
    expect(OrderService.last.carrier).to eq carrier
    expect(page).to have_content('Ordem de Serviço cadastrada com sucesso.')
    expect(page).to have_content('Ordens de Serviço')
    expect(page).to have_content('Ordem de Serviço ABCD1234EFGH567')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Frete de 150Km de distância com item de 1m² e 2Kg')   
    expect(page).to have_content('Valor: 8000')
    expect(page).to have_content('Prazo: 2')
    expect(page).to have_content('Endereço para Retirada: R. dos Andradas, 1001 - Porto Alegre - RS')
    expect(page).to have_content('Endereço para Entrega: R. Luís Augusto Branco, 97 - Ipê - RS')
    expect(page).to have_content('Status: Pendente')
  end

  it 'com dados incompletos' do
    # Arrange
   carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                    registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                    city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                    status: 'enabled')
   Price.create!(initial_volume: 0, final_volume: 1, initial_weight: 0, final_weight: 3, price_km: 50,
                 carrier: carrier)  
   Kilometer.create!(initial_kilometer: 100, final_kilometer: 200, price_km: 8000, carrier: carrier)               
   Deadline.create!(initial_kilometer: 100, final_kilometer: 200, deadline: 2, carrier: carrier)
   allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD1234EFGH567')
   # Act
   visit root_path
   click_on 'Fazer Orçamento'
   fill_in 'Altura do Item', with: '1'
   fill_in 'Largura do Item', with: '1'
   fill_in 'Profundidade do Item', with: '1'
   fill_in 'Peso do Item', with: '2'
   fill_in 'Distância', with: '150'
   click_on 'Enviar'
   click_on 'Criar Ordem de Serviço'
   within('div#search') do
     fill_in 'Endereço', with: ''
     fill_in 'Cidade', with: ''
     fill_in 'Estado', with: ''
   end
   fill_in 'Código do Produto', with: ''
   within('div#delivery') do
     fill_in 'Endereço', with: ''
     fill_in 'Cidade', with: ''
     fill_in 'Estado', with: ''
   end
   fill_in 'Nome', with: ''
   fill_in 'CPF', with: ''
   click_on 'Enviar'
   # Assert
   expect(page).to have_content('Ordem de Serviço não cadastrada.')
   expect(page).to have_content('Endereço não pode ficar em branco')
   expect(page).to have_content('Cidade não pode ficar em branco')
   expect(page).to have_content('Estado não pode ficar em branco')
   expect(page).to have_content('Endereço não pode ficar em branco')
   expect(page).to have_content('Cidade não pode ficar em branco')
   expect(page).to have_content('Estado não pode ficar em branco')
   expect(page).to have_content('Cidade não pode ficar em branco')
   expect(page).to have_content('Nome não pode ficar em branco')
   expect(page).to have_content('CPF não pode ficar em branco')
 end
end