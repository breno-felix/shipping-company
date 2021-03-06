require 'rails_helper'

RSpec.describe Volume, type: :model do
  describe '#valid?' do
    context 'required attributes' do
      it 'false when final_volume is empty' do
        # Arrange
        price = Volume.new(final_volume: '')
        # Act
        price.valid?
        result = price.errors.include?(:final_volume) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when price_km is empty' do
        # Arrange
        price = Volume.new(price_km: '')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it 'false when initial_volume is empty' do
        # Arrange
        price = Volume.new(initial_volume: '')
        # Act
        price.valid?
        result = price.errors.include?(:initial_volume) 
        # Assert
        expect(result).to be true
      end
    end

    context 'definitions for numeric attributes' do 
      it "false when initial_volume is not just numeric digits" do
         # Arrange
         price = Volume.new(initial_volume: 'abc10')
         # Act
         price.valid?
         result = price.errors.include?(:initial_volume) 
         # Assert
         expect(result).to be true
      end

      it "false when final_volume is not just numeric digits" do
        # Arrange
        price = Volume.new(final_volume: 'abc10')
        # Act
        price.valid?
        result = price.errors.include?(:final_volume) 
        # Assert
        expect(result).to be true
      end

      it "false when price_km is not just numeric digits" do
        # Arrange
        price = Volume.new(price_km: 'abc10')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it "false when price_km is less than 0" do
        # Arrange
        price = Volume.new(price_km: '-3')
        # Act
        price.valid?
        result = price.errors.include?(:price_km) 
        # Assert
        expect(result).to be true
      end

      it "false when final_volume is less than initial_volume" do
        # Arrange
        price = Volume.new(final_volume: '3',initial_volume: '4')
        # Act
        price.valid?
        result = price.errors.include?(:final_volume) 
        # Assert
        expect(result).to be true
      end
    end  
  end
  
end
