require_relative '../models/coin.rb'

RSpec.describe Coin do
  before do

  end

  it 'is created with a value' do
    coin = Coin.new
    coin.value = 5

    expect(coin.value = 5)
  end

  it 'only has values of 1 2 5 10 20 50 100 200' do
    allowed_denominations = [1, 2, 5, 10, 20, 50, 100, 200]

    allowed_denominations.each do |amount|
      expect{
        coin = Coin.new
        coin.value = amount
      }.not_to raise_error
    end
  end

  it 'raises an error if a  coin is created with an incorrect value' do
    incorrect_amount = 3

    expect{
      coin = Coin.new
      coin.value = incorrect_amount
    }.to raise_error
  end
end
