require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'required attributes' do
      it 'false when brand is empty' do
        # Arrange
        vehicle = Vehicle.new(brand: '')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:brand) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when model is empty' do
        # Arrange
        vehicle = Vehicle.new(model: '')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:model) 
        # Assert
        expect(result).to be true
      end

      it 'false when year is empty' do
        # Arrange
        vehicle = Vehicle.new(year: '')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:year) 
        # Assert
        expect(result).to be true
      end
      
      it 'false when plate is empty' do
        # Arrange
        vehicle = Vehicle.new(plate: '')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:plate) 
        # Assert
        expect(result).to be true
      end

      it 'false when capacity is empty' do
        # Arrange
        vehicle = Vehicle.new(capacity: '')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:capacity) 
        # Assert
        expect(result).to be true
      end
    end

    context 'definitions for numeric attributes' do 
      it "false when year is not just numeric digits" do
        # Arrange
        vehicle = Vehicle.new(year: 'abc123')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:year) 
        # Assert
        expect(result).to be true
      end

      it "false when capacity is not just numeric digits" do
        # Arrange
        vehicle = Vehicle.new(capacity: 'abc123')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:capacity) 
        # Assert
        expect(result).to be true
      end

      it "false when year is less than 1991" do
        # Arrange
        vehicle = Vehicle.new(year: '1990')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:year) 
        # Assert
        expect(result).to be true
      end

      it "false when capacity is less than 1" do
        # Arrange
        vehicle = Vehicle.new(capacity: '0')
        # Act
        vehicle.valid?
        result = vehicle.errors.include?(:capacity) 
        # Assert
        expect(result).to be true
      end
    end 
  end
end
