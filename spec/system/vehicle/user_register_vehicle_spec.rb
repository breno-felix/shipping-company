require 'rails_helper'

describe 'Usuário cadastra Veículo' do
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
    click_on 'Cadastrar Veículo'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Cadastrar Veículo')
    expect(page).to have_field('Marca')
    expect(page).to have_field('Modelo')
    expect(page).to have_field('Ano')
    expect(page).to have_field('Placa')
    expect(page).to have_field('Capacidade')
  end

  it 'com sucesso' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Marca', with: 'Volvo'
    fill_in 'Modelo', with: 'VM 270'
    fill_in 'Ano', with: '2021'
    fill_in 'Placa', with: 'LSN4I49'
    fill_in 'Capacidade', with: '35000'
    click_on 'Cadastrar'
    # Assert
    expect(current_path).to eq carrier_vehicles_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(Vehicle.last.carrier).to eq carrier
    expect(page).to have_content('Lista de Veículos')
    expect(page).to have_content('Volvo VM 270 - 2021')
    expect(page).to have_content('Placa: LSN4I49')
    expect(page).to have_content('Capacidade: 35000 Kg')

  end

  it 'com dados incompletos' do
    # Arrange
    carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Ano', with: ''
    fill_in 'Placa', with: ''
    fill_in 'Capacidade', with: ''
    click_on 'Cadastrar'

    # Assert
    #expect(current_path).to eq new_carrier_vehicle_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).to have_content('Veículo não cadastrado.')
    expect(page).to have_content('Marca não pode ficar em branco')
    expect(page).to have_content('Modelo não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Capacidade não pode ficar em branco')
  end

  it 'com capacidade menor que 1' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Marca', with: 'Volvo'
    fill_in 'Modelo', with: 'VM 270'
    fill_in 'Ano', with: '2021'
    fill_in 'Placa', with: 'LSN4I49'
    fill_in 'Capacidade', with: '0'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Veículo não cadastrado.')
    expect(page).to have_content('Capacidade deve ser maior que 0')
  end

  it 'com ano menor que 1991' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Veículos'
    click_on 'Cadastrar Veículo'
    fill_in 'Marca', with: 'Volvo'
    fill_in 'Modelo', with: 'VM 270'
    fill_in 'Ano', with: '1990'
    fill_in 'Placa', with: 'LSN4I49'
    fill_in 'Capacidade', with: '35000'
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Veículo não cadastrado.')
    expect(page).to have_content('Ano deve ser maior que 1990')
  end
end