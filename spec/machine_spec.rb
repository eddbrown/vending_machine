require_relative '../models/machine.rb'
require_relative '../models/coin.rb'
require_relative '../models/item.rb'

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

  it 'can dispense an item' do
    machine = Machine.new
    machine.reload_items

    expect(machine.item_count('A')).to eq(Machine::MAX_ITEM_CAPACITY)

    item = machine.dispense_item('A')
    expect(item).to be_an(Item)
    expect(item.code).to eq('A')

    expect(machine.item_count('A')).to eq(Machine::MAX_ITEM_CAPACITY - 1)
  end
end
