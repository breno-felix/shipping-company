require 'rails_helper'

describe 'Usuário cadastra preços para volume' do
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
    click_on 'Volume'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Cadastrar Preços: para intervalo de volume')
    expect(page).to have_content('Volume Inicial')
    expect(page).to have_field('Volume Final')
    expect(page).to have_field('Valor por Km')
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
    click_on 'Preços'
    click_on 'Volume'
    fill_in 'Volume Final', with: '1'
    fill_in 'Valor por Km', with: '20'
    click_on 'Cadastrar'
    fill_in 'Volume Final', with: '3'
    fill_in 'Valor por Km', with: '35'
    click_on 'Cadastrar'
    # Assert
    expect(current_path).to eq new_carrier_volume_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(Volume.last.carrier).to eq carrier
    expect(page).to have_content('Tabela de preços por intervalos de volume')
    expect(page).to have_content('Volume Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('2')
    expect(page).to have_content('Volume Final')
    expect(page).to have_content('1')
    expect(page).to have_content('3')
    expect(page).to have_content('Valor por Km')
    expect(page).to have_content('20')
    expect(page).to have_content('35')
  end

  it 'com dados incompletos' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Preços'
    click_on 'Volume'
    fill_in 'Volume Final', with: ''
    fill_in 'Valor por Km', with: ''
    click_on 'Cadastrar' 

    # Assert
    expect(page).to have_content('Preço para intervalo de volume não cadastrado.')
    expect(page).to have_content('Volume Final não pode ficar em branco')
    expect(page).to have_content('Valor por Km não pode ficar em branco')
  end

  it 'com volume final menor que o volume inicial' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Preços'
    click_on 'Volume'
    fill_in 'Volume Final', with: '4'
    fill_in 'Valor por Km', with: '20'
    click_on 'Cadastrar' 
    fill_in 'Volume Final', with: '3'
    fill_in 'Valor por Km', with: '10'
    click_on 'Cadastrar' 

    # Assert
    expect(page).to have_content('Preço para intervalo de volume não cadastrado.')
    expect(page).to have_content('Volume Final deve ser maior que 4')
  end

  it 'com preço menor que 0' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Preços'
    click_on 'Volume'
    fill_in 'Volume Final', with: '4'
    fill_in 'Valor por Km', with: '-1'
    click_on 'Cadastrar' 

    # Assert
    expect(page).to have_content('Preço para intervalo de volume não cadastrado.')
    expect(page).to have_content('Valor por Km deve ser maior ou igual a 0')
  end
  
end