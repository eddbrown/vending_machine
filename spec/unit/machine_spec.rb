RSpec.describe Machine do

  context '#item_count' do
    it 'counts the items of a given code' do
      machine = Machine.new
      expect(machine.item_count(:B)).to eq(Machine::MAX_ITEM_CAPACITY)
    end
  end

  context '#coin_count' do
    it 'can count the coins' do
      Machine::ALLOWED_DENOMINATIONS.each do |denomination|
        machine = Machine.new

        expect(machine.coin_count(denomination)).to eq(Machine::MAX_COIN_CAPACITY)

        # Also checks that it recognises a change in the count
        expect{machine.add_coin(denomination)}.to change{
          machine.coin_count(denomination)
        }.by 1
      end
    end
  end

  context '#dispense_coin' do
    it 'can dispense a coin' do
      machine = Machine.new

      Machine::ALLOWED_DENOMINATIONS.each do |denomination|
        machine = Machine.new

        machine = Machine.new

        expect{machine.dispense_coin(denomination)}.to change{
          machine.coin_count(denomination)
        }.by -1
      end
    end
  end

  context '#reload_items' do
    it 'reloads items into the machine' do
      machine = Machine.new
      machine.reload_items

      [:A,:B,:C,:D,:E,:F,:G,:H,:I,:J].each do |code|
        expect(machine.item_count(code)).to eq(Machine::MAX_ITEM_CAPACITY)
      end
    end
  end

  context '#reload_coins' do
    it 'reloads coins into the machine' do
      machine = Machine.new
      machine.reload_coins

      Machine::ALLOWED_DENOMINATIONS.each do |denomination|
        expect(machine.coin_count(denomination)).to eq(Machine::MAX_COIN_CAPACITY)
      end
    end
  end

  it 'dispenses an item' do
    machine = Machine.new
    machine.reload_items

    expect(machine.item_count(:A)).to eq(Machine::MAX_ITEM_CAPACITY)

    item = machine.dispense_item(:A)
    expect(item).to be_an(Item)
    expect(item.code).to eq(:A)

    expect(machine.item_count(:A)).to eq(Machine::MAX_ITEM_CAPACITY - 1)
  end

  it 'asks the calculator to provide it with a list of change to return' do
    machine = Machine.new
    machine.reload_items
    calc = double(compute_change: :list)
    cost = 1.0
    tender = 2.0

    allow(Calculator).to receive(:new) { calc }

    expect(machine.compute_change(cost, tender)).to eq(:list)
  end

  context "#choose" do
    it 'dispenses the chosen item and change according to the computed list' do
      machine = Machine.new
      machine.reload_items
      machine.reload_coins
      item = double

      list = {
        0.01 => 0,
        0.02 => 0,
        0.05 => 0,
        0.1 => 0,
        0.2 => 0,
        0.5 => 0,
        1.0 => 0,
        2.0 => 2
      }

      calc = double(compute_change: list)
      allow(Calculator).to receive(:new) { calc }
      allow(machine).to receive(:dispense_item) { item }

      expect(machine.choose(:B, 5.00)).to eq({
        item: item,
        change: [2.0, 2.0]
      })
    end

    it 'raises an error if the cost of the item is more than the tender' do
      machine = Machine.new
      machine.reload_items
      machine.reload_coins
      cost = 1.00
      tender = 0.1

      expect{ machine.choose(:B, tender) }.to raise_error('Insufficient Funds')
    end
  end

  context "#empty" do
    it 'empties its contents' do
      machine = Machine.new
      machine.empty

      expect(machine.coin_count(0.01)).to eq(0)
      expect(machine.item_count(:B)).to eq(0)
    end
  end
end
