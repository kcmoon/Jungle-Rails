require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should create a new product with required fields are valid' do
      @category = Category.new
      @product = Product.new(name: "Mr Potato Head", price_cents: 10000, quantity: 1, category: @category)
      expect(@product).to be_valid
    end

    it 'should fail without a name' do
      @category = Category.new
      @product = Product.new(name: nil, price_cents: 10000, quantity: 1, category: @category)
      expect(@product).to be_invalid
    end

    it 'should fail without a price' do
      @category = Category.new
      @product = Product.new(name: "Mr Potato Head", price_cents: nil, quantity: 1, category: @category)
      expect(@product).to be_invalid
    end

    it 'should fail without a quantity' do
      @category = Category.new
      @product = Product.new(name: "Mr Potato Head", price_cents: 10000, quantity: nil, category: @category)
      expect(@product).to be_invalid
    end

    it 'should fail without a category' do
      @category = Category.new
      @product = Product.new(name: "Mr Potato Head", price_cents: 10000, quantity: 1, category: nil)
      expect(@product).to be_invalid
    end

  end
end
