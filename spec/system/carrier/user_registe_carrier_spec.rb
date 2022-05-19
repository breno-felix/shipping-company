require 'rails_helper'

describe 'Usuário cadastra uma Transportadora' do
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Transportadora'
    # Assert
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Domínio do E-mail')
  end

  it 'com sucesso' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Cadastrar Transportadora'
    fill_in 'Nome Fantasia', with: 'RV Express'
    fill_in 'Razão Social', with: 'RV Express LTDA'
    fill_in 'CNPJ', with: '19950592000130'
    fill_in 'Endereço', with: 'Rua Áustria, 375'
    fill_in 'Cidade', with: 'Cachoeirinha'
    fill_in 'Estado', with: 'RS'
    fill_in 'Domínio do E-mail', with: 'rvexpress.com'
    click_on 'Enviar'
    # Assert
    expect(current_path).to eq carrier_path(Carrier.find_by(brand_name: 'RV Express'))
    expect(page).not_to have_content('Transportadora não cadastrada')
    expect(page).to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('Transportadora RV Express')
    expect(page).to have_content('RV Express LTDA')
    expect(page).to have_content('Documento: 19950592000130')
    expect(page).to have_content('Endereço: Rua Áustria, 375 - Cachoeirinha - RS')
    
  end

  it 'com dados incompletos' do
    # Arrange

     # Act
     visit root_path
     click_on 'Cadastrar Transportadora'
     fill_in 'Nome Fantasia', with: ''
     fill_in 'Razão Social', with: ''
     fill_in 'CNPJ', with: ''
     fill_in 'Endereço', with: ''
     fill_in 'Cidade', with: ''
     fill_in 'Estado', with: ''
     fill_in 'Domínio do E-mail', with: ''
     click_on 'Enviar'
    # Assert
    expect(page).not_to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('Transportadora não cadastrada')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('Razão Social não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
    expect(page).to have_content('Domínio do E-mail não pode ficar em branco')
  end
end