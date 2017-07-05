require_relative '../models/item.rb'

RSpec.describe Item do
  it 'has a code' do
    diet_coke = Item.new('A')

    expect(diet_coke.code).to eq('A')
  end

  it 'has a cost' do
    diet_coke = Item.new('diet_coke')
    diet_coke.cost = 0.5

    expect(diet_coke.cost).to eq(0.5)
  end
end
