require 'rails_helper'

describe 'Usuário cadastra prazo por Km' do
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
    click_on 'Km'
    # Assert
    expect(page).to have_link('Br Transportadoras', href: root_path)
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
    expect(page).to have_link('RV Express', href: carrier_path(Carrier.find_by(brand_name: 'RV Express')))
    expect(page).to have_content('Cadastrar Prazos: para intervalo de Km')
    expect(page).to have_content('Km Inicial')
    expect(page).to have_field('Km Final')
    expect(page).to have_field('Prazo')
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
    click_on 'Prazos'
    click_on 'Km'
    fill_in 'Km Final', with: '100'
    fill_in 'Prazo', with: '1'
    click_on 'Cadastrar'
    fill_in 'Km Final', with: '200'
    fill_in 'Prazo', with: '2'
    click_on 'Cadastrar'
    # Assert
    expect(current_path).to eq new_carrier_deadline_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(Deadline.last.carrier).to eq carrier
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

  it 'com dados incompletos' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Prazos'
    click_on 'Km'
    fill_in 'Km Final', with: ''
    fill_in 'Prazo', with: ''
    click_on 'Cadastrar'

    # Assert
    expect(page).to have_content('Prazo para intervalo de Km não cadastrado.')
    expect(page).to have_content('Km Final não pode ficar em branco')
    expect(page).to have_content('Prazo não pode ficar em branco')
  end

  it 'com Km final menor que o Km inicial' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Prazo'
    click_on 'Km'
    fill_in 'Km Final', with: '100'
    fill_in 'Prazo', with: '2'
    click_on 'Cadastrar' 
    fill_in 'Km Final', with: '50'
    fill_in 'Prazo', with: '1'
    click_on 'Cadastrar' 

    # Assert
    expect(page).to have_content('Prazo para intervalo de Km não cadastrado.')
    expect(page).to have_content('Km Final deve ser maior que 100')
  end

  it 'com prazo menor que 1' do
    # Arrange
    Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
    # Act
    visit root_path
    click_on 'RV Express'
    click_on 'Prazo'
    click_on 'Km'
    fill_in 'Km Final', with: '100'
    fill_in 'Prazo', with: '0'
    click_on 'Cadastrar' 

    # Assert
    expect(page).to have_content('Prazo para intervalo de Km não cadastrado.')
    expect(page).to have_content('Prazo deve ser maior que 0')
  end
end