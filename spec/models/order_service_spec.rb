require 'rails_helper'

RSpec.describe OrderService, type: :model do
  describe 'generate a random code' do
    it 'when creating a new order' do
      # Arrange
      carrier = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
      vehicle = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                    capacity: '35000', carrier: carrier)
      order_service = OrderService.new(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', carrier: carrier, vehicle: vehicle) 
      # Act
      order_service.save!
      result = order_service.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 15
    end

    it 'and the code is unique' do
      # Arrange
      carrier_first = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
      carrier_second = Carrier.create!(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
                      registration_number: '18519324000104', full_address: 'Rua Valdir Dantas, 440',
                      city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
                      status: 'enabled') 
      vehicle_first = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                      capacity: '35000', carrier: carrier_first)
      vehicle_second = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'OZN7I87',
                        capacity: '35000', carrier: carrier_second)
      order_service_first = OrderService.create!(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', carrier: carrier_first, vehicle: vehicle_first) 
      order_service_second = OrderService.new(search_address: 'R. dos Andradas, 1001', search_city: 'Porto Alegre',
                          search_state: 'RS', product_code: 'ABC123', volume: 1, weight: 2, 
                          delivery_address: 'R. Luís Augusto Branco, 97', delivery_city: 'Ipê',
                          delivery_state: 'RS', distance: 150, price: 8000, deadline: 2,
                          name: 'Breno Felix', cpf: '02398746509', carrier: carrier_second, vehicle: vehicle_second)
      # Act
      order_service_second.save!
      result = order_service_second.code
      # Assert
      expect(result).not_to eq order_service_first.code
    end
  end

  describe '#valid?' do
    context 'required attributes' do
      it 'false when search_address is empty' do
        # Arrange
        order_service = OrderService.new(search_address: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:search_address) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when search_city is empty' do
        # Arrange
        order_service = OrderService.new(search_city: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:search_city) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when search_state is empty' do
        # Arrange
        order_service = OrderService.new(search_state: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:search_state) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when product_code is empty' do
        # Arrange
        order_service = OrderService.new(product_code: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:product_code) 
        # Assert
        expect(result).to be true
      end

      it 'false when volume is empty' do
        # Arrange
        order_service = OrderService.new(volume: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:volume) 
        # Assert
        expect(result).to be true
      end

      it 'false when weight is empty' do
        # Arrange
        order_service = OrderService.new(weight: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:weight) 
        # Assert
        expect(result).to be true
      end

      it 'false when delivery_address is empty' do
        # Arrange
        order_service = OrderService.new(delivery_address: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:delivery_address) 
        # Assert
        expect(result).to be true
      end

      it 'false when delivery_city is empty' do
        # Arrange
        order_service = OrderService.new(delivery_city: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:delivery_city) 
        # Assert
        expect(result).to be true
      end

      it 'false when delivery_state is empty' do
        # Arrange
        order_service = OrderService.new(delivery_state: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:delivery_state) 
        # Assert
        expect(result).to be true
      end

      it 'false when distance is empty' do
        # Arrange
        order_service = OrderService.new(distance: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:distance) 
        # Assert
        expect(result).to be true
      end

      it 'false when price is empty' do
        # Arrange
        order_service = OrderService.new(price: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:price) 
        # Assert
        expect(result).to be true
      end

      it 'false when deadline is empty' do
        # Arrange
        order_service = OrderService.new(deadline: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:deadline) 
        # Assert
        expect(result).to be true
      end

      it 'false when name is empty' do
        # Arrange
        order_service = OrderService.new(name: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:name) 
        # Assert
        expect(result).to be true
      end

      it 'false when cpf is empty' do
        # Arrange
        order_service = OrderService.new(cpf: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:cpf) 
        # Assert
        expect(result).to be true
      end

      it 'false when status is empty' do
        # Arrange
        order_service = OrderService.new(status: '')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:status) 
        # Assert
        expect(result).to be true
      end

    end

    context 'cpf attribute has a length of 11 numeric digits' do
      it "true when it has 14 numeric digits" do
        # Arrange
        order_service = OrderService.new(cpf: '02398746509')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:cpf) 
        # Assert
        expect(result).to be false
      end
      
      it "false when there is more character than necessary" do
        # Arrange
        order_service = OrderService.new(cpf: '023987465099')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:cpf) 
        # Assert
        expect(result).to be true
      end
      
      it "false when there is less character than necessary" do
        # Arrange
        order_service = OrderService.new(cpf: '0239874650')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:cpf) 
        # Assert
        expect(result).to be true
      end

      it "false when not just numeric digits" do
        # Arrange
        order_service = OrderService.new(cpf: 'abc9874650d')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:cpf) 
        # Assert
        expect(result).to be true
      end
    end  

    context 'vehicle must belong to the carrier that received the Order Servicee' do
      it "and is false when vehicle does not belong" do
        # Arrange
        carrier_first = Carrier.create!(corporate_name: 'RV Express LTDA', brand_name: 'RV Express', 
                      registration_number: '19950592000130', full_address: 'Rua Áustria, 375',
                      city: 'Cachoeirinha', state: 'RS', email_domain: 'rvexpress.com',
                      status: 'enabled')
        carrier_second = Carrier.create!(corporate_name: 'R2 Logistica LTDA', brand_name: 'R2 Logistica', 
                      registration_number: '18519324000104', full_address: 'Rua Valdir Dantas, 440',
                      city: 'Fortaleza', state: 'CE', email_domain: 'r2logistica.com.br',
                      status: 'enabled') 
        vehicle_first = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'LSN4I49',
                      capacity: '35000', carrier: carrier_first)
        vehicle_second = Vehicle.create!(brand: 'Volvo', model: 'VM 270', year: '2021', plate: 'OZN7I87',
                        capacity: '35000', carrier: carrier_second)
        order_service = OrderService.new(carrier: carrier_second, vehicle: vehicle_first)
        # Act
        order_service.valid?
        result = order_service.errors.include?(:vehicle) 
        # Assert
        expect(result).to be true
      end
      
      it "and is true when vehicle belongs" do
        # Arrange
        order_service = OrderService.new(cpf: '023987465099')
        # Act
        order_service.valid?
        result = order_service.errors.include?(:cpf) 
        # Assert
        expect(result).to be true
      end
    end 
  end
end
