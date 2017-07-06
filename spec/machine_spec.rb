require_relative '../models/machine.rb'
require_relative '../models/coin.rb'
require_relative '../models/item.rb'
require_relative '../models/calculator.rb'

RSpec.describe Machine do
  it 'can add a coin' do
    Machine::ALLOWED_DENOMINATIONS.each do |denomination|
      machine = Machine.new

      machine.add_coin(denomination)
      expect(machine.coin_count(denomination)).to eq(1)
    end
  end

  it 'can dispense a coin' do
    machine = Machine.new

    Machine::ALLOWED_DENOMINATIONS.each do |denomination|
      machine = Machine.new

      machine.add_coin(denomination)
      expect(machine.coin_count(denomination)).to eq(1)

      machine.dispense_coin(denomination)
      expect(machine.coin_count(denomination)).to eq(0)
    end
  end

  it 'reloads items' do
    machine = Machine.new
    machine.reload_items

    Machine::ITEM_CODES.each do |code|
      expect(machine.item_count(code)).to eq(Machine::MAX_ITEM_CAPACITY)
    end
  end

  it 'reloads coins' do
    machine = Machine.new
    machine.reload_coins

    Machine::ALLOWED_DENOMINATIONS.each do |denomination|
      expect(machine.coin_count(denomination)).to eq(Machine::MAX_COIN_CAPACITY)
    end
  end

  it 'dispenses an item' do
    machine = Machine.new
    machine.reload_items

    expect(machine.item_count('A')).to eq(Machine::MAX_ITEM_CAPACITY)

    item = machine.dispense_item('A')
    expect(item).to be_an(Item)
    expect(item.code).to eq('A')

    expect(machine.item_count('A')).to eq(Machine::MAX_ITEM_CAPACITY - 1)
  end

  it 'asks the calculator to provide it with a list of change to return' do
    machine = Machine.new
    machine.reload_items
    change_list = double(compute_change: :list)

    allow(Calculator).to receive(:new) { change_list }

    expect(machine.compute_change('A', 1.0)).to eq(:list)
  end

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

    expect(machine.choose('B', 5.00)).to eq({
      item: item,
      change: [2.0, 2.0]
    })
  end
end
