require 'rails_helper'

RSpec.describe Weight, type: :model do
  describe '#valid?' do
    context 'required attributes' do
      it 'false when final_weight is empty' do
        # Arrange
        price = Weight.new(final_weight: '')
        # Act
        price.valid?
        result = price.errors.include?(:final_weight) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when price_km is empty' do
        # Arrange
        price = Weight.new(price_km: '')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it 'false when initial_weight is empty' do
        # Arrange
        price = Weight.new(initial_weight: '')
        # Act
        price.valid?
        result = price.errors.include?(:initial_weight) 
        # Assert
        expect(result).to be true
      end
    end

    context 'definitions for numeric attributes' do 
      it "false when initial_weight is not just numeric digits" do
         # Arrange
         price = Weight.new(initial_weight: 'abc10')
         # Act
         price.valid?
         result = price.errors.include?(:initial_weight) 
         # Assert
         expect(result).to be true
      end

      it "false when final_weight is not just numeric digits" do
        # Arrange
        price = Weight.new(final_weight: 'abc10')
        # Act
        price.valid?
        result = price.errors.include?(:final_weight) 
        # Assert
        expect(result).to be true
      end

      it "false when price_km is not just numeric digits" do
        # Arrange
        price = Weight.new(price_km: 'abc10')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it "false when price_km is less than 0" do
        # Arrange
        price = Weight.new(price_km: '-3')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it "false when final_weight is less than initial_weight" do
        # Arrange
        price = Weight.new(final_weight: '3',initial_weight: '4')
        # Act
        price.valid?
        result = price.errors.include?(:final_weight) 
        # Assert
        expect(result).to be true
      end
    end 
  end
end
