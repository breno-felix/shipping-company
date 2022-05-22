require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    context 'required attributes' do
      it 'false when final_kilometer is empty' do
        # Arrange
        deadline = Deadline.new(final_kilometer: '')
        # Act
        deadline.valid?
        result = deadline.errors.include?(:final_kilometer) 
        # Assert
        expect(result).to be true
      end
    
      it 'false when deadline is empty' do
        # Arrange
        deadline = Deadline.new(deadline: '')
        # Act
        deadline.valid?
        result = deadline.errors.include?(:deadline) 
        # Assert
        expect(result).to be true
      end

      it 'false when initial_kilometer is empty' do
        # Arrange
        deadline = Deadline.new(initial_kilometer: '')
        # Act
        deadline.valid?
        result = deadline.errors.include?(:initial_kilometer) 
        # Assert
        expect(result).to be true
      end
    end

    context 'definitions for numeric attributes' do 
      it "false when initial_kilometer is not just numeric digits" do
         # Arrange
         deadline = Deadline.new(initial_kilometer: 'abc10')
         # Act
         deadline.valid?
         result = deadline.errors.include?(:initial_kilometer) 
         # Assert
         expect(result).to be true
      end

      it "false when final_kilometer is not just numeric digits" do
        # Arrange
        deadline = Deadline.new(final_kilometer: 'abc10')
        # Act
        deadline.valid?
        result = deadline.errors.include?(:final_kilometer) 
        # Assert
        expect(result).to be true
      end

      it "false when deadline is not just numeric digits" do
        # Arrange
        deadline = Deadline.new(deadline: 'abc10')
        # Act
        deadline.valid?
        result = deadline.errors.include?(:deadline) 
        # Assert
        expect(result).to be true
      end

      it "false when deadline is less than 1" do
        # Arrange
        deadline = Deadline.new(deadline: '-3')
        # Act
        deadline.valid?
        result = deadline.errors.include?(:deadline) 
        # Assert
        expect(result).to be true
      end

      it "false when final_kilometer is less than initial_kilometer" do
        # Arrange
        deadline = Deadline.new(final_kilometer: '3',initial_kilometer: '4')
        # Act
        deadline.valid?
        result = deadline.errors.include?(:final_kilometer) 
        # Assert
        expect(result).to be true
      end
    end 
  end
end
