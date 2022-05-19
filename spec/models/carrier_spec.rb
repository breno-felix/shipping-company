require 'rails_helper'

RSpec.describe Carrier, type: :model do
  describe '#valid?' do
    context 'required attributes' do
      it 'false when corporate_name is empty' do
        # Arrange
        carrier = Carrier.new(corporate_name: '', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end
    
      it 'false when brand_name is empty' do
        # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: '', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end
    
      it 'false when registration_number is empty' do
        # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end
    
      it 'false when email_domain is empty' do
        # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: '',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end

      it 'false when full_address is empty' do
        # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: '',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: '', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end

      it 'false when state is empty' do
        # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: '', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end
    end
    context 'unique attributes' do
      it 'false when registration_number is already in use' do
        # Arrange
        first_carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        
        second_carrier = Carrier.new(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
                     registration_number: '19950592000130', full_address: 'Rua Valdir Dantas, 440',
                     city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
                     status: 'enabled')
        # Act
        result = second_carrier.valid?
        # Assert
        expect(result).to eq false
      end
    end
    context 'registration_number attribute has a length of 14 numeric digits' do
      it "true when it has 14 numeric digits" do
        # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq true
      end
      
      it "false when there is more character than necessary" do
         # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '199505920001309', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end
      
      it "false when there is less character than necessary" do
         # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: '1995059200013', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end

      it "false when not just numeric digits" do
         # Arrange
        carrier = Carrier.new(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                     registration_number: 'K99505C200013P', full_address: 'Rua Áustria, 375',
                     city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                     status: 'enabled')
        # Act
        result = carrier.valid?
        # Assert
        expect(result).to eq false
      end
    end  
  end
end