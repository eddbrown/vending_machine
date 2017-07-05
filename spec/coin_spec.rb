require_relative '../models/coin.rb'

RSpec.describe Coin do
  before do

  end

  it 'is created with a value' do
    coin = Coin.new
    coin.value = 0.5

    expect(coin.value).to eq(0.5)
  end

  it 'only has values of 1 2 5 10 20 50 100 200' do
    allowed_denominations = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]

    allowed_denominations.each do |amount|
      expect{
        coin = Coin.new
        coin.value = amount
      }.not_to raise_error
    end
  end

  it 'raises an error if a  coin is created with an incorrect value' do
    incorrect_amount = 3.0

    expect{
      coin = Coin.new
      coin.value = incorrect_amount
    }.to raise_error('Incorrect denomination for coin')
  end
end
