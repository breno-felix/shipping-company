require 'rails_helper'

RSpec.describe Kilometer, type: :model do
  describe '#valid?' do
    context 'required attributes' do
      it 'false when final_kilometer is empty' do
        # Arrange
        price = Kilometer.new(final_kilometer: '')
        # Act
        price.valid?
        result = price.errors.include?(:final_kilometer) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when price_km is empty' do
        # Arrange
        price = Kilometer.new(price_km: '')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it 'false when initial_kilometer is empty' do
        # Arrange
        price = Kilometer.new(initial_kilometer: '')
        # Act
        price.valid?
        result = price.errors.include?(:initial_kilometer) 
        # Assert
        expect(result).to be true
      end
    end

    context 'definitions for numeric attributes' do 
      it "false when initial_kilometer is not just numeric digits" do
         # Arrange
         price = Kilometer.new(initial_kilometer: 'abc10')
         # Act
         price.valid?
         result = price.errors.include?(:initial_kilometer) 
         # Assert
         expect(result).to be true
      end

      it "false when final_kilometer is not just numeric digits" do
        # Arrange
        price = Kilometer.new(final_kilometer: 'abc10')
        # Act
        price.valid?
        result = price.errors.include?(:final_kilometer) 
        # Assert
        expect(result).to be true
      end

      it "false when price_km is not just numeric digits" do
        # Arrange
        price = Kilometer.new(price_km: 'abc10')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it "false when price_km is less than 0" do
        # Arrange
        price = Kilometer.new(price_km: '-3')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it "false when final_kilometer is less than initial_kilometer" do
        # Arrange
        price = Kilometer.new(final_kilometer: '3',initial_kilometer: '4')
        # Act
        price.valid?
        result = price.errors.include?(:final_kilometer) 
        # Assert
        expect(result).to be true
      end
    end 
  end
end
