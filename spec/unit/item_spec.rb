RSpec.describe Item do
  it 'has a code' do
    diet_coke = Item.new('A')

    expect(diet_coke.code).to eq('A')
  end
end
