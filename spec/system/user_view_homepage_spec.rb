require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    #Arrange (nesse caso pode ficar vazio, pois é o início)

    # Act
    visit(root_path)
    # Assert
    expect(page).to have_content('Br Transportadoras')
    expect(page).to have_content('Empresa especializada em gestão de transportadoras')
  end
end