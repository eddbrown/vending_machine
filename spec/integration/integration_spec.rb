# These integration tests are here for dual purpose.
# 1. To test the models are working together without stubbing. Further tests are
#    carried out in the unit tests which are more granular.

# 2. To specifically test the items in the brief.

RSpec.describe  "Choosing an Item" do
  context "Consumer chooses an item" do
    denominations = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.00, 2.00]
    coin_capacity = Machine::MAX_COIN_CAPACITY
    item_capacity = Machine::MAX_ITEM_CAPACITY

    it "returns an item with the chosen code and correct change" do
      # Load up the machine
      machine = Machine.new
      machine.reload_items
      machine.reload_coins

      # Item is chosen and the change is more than the item cost (here item cost
      # is 1, but the change is 2.17)
      returned = machine.choose(:B, 2.17)
      change = returned[:change]
      item = returned[:item]
      expect(change).to eq [0.02, 0.05, 0.1, 1.0]


      expect(item).to be_an Item
      expect(item.code).to eq(:B)
    end

    it "raises an error if the entered money is not enough" do
      # Load up the machine
      machine = Machine.new
      machine.reload_items
      machine.reload_coins

      # Item is chosen and the change is less than the item cost so an error is
      # raised
      expect{ machine.choose(:B, 0.9) }.to raise_error('Insufficient Funds')
    end

    it "takes an initial load of coins and items" do
      machine = Machine.new

      # Check to make sure there are initially coins of each denomination
      denominations.each do |denom|
        expect(machine.coin_count(denom)).to eq(coin_capacity)
      end

      expect(machine.item_count(:B)).to eq(item_capacity)
    end

    it "reloads items and coins" do
      machine = Machine.new

      # Machine initially has full items and coins
      expect(machine.item_count(:A)).to eq(item_capacity)
      expect(machine.coin_count(0.01)).to eq(coin_capacity)

      # Empty the machine
      machine.empty

      # Check that it is empty
      expect(machine.item_count(:A)).to eq(0)
      expect(machine.coin_count(0.01)).to eq(0)

      # Reload Machine
      machine.reload_items
      machine.reload_coins

      # Check it has reloaded its items
      expect(machine.item_count(:A)).to eq(item_capacity)
      expect(machine.coin_count(0.01)).to eq(coin_capacity)
    end

    it "keeps track of its products" do
      # Load up the machine
      machine = Machine.new
      machine.reload_items
      machine.reload_coins

      # Item is chosen and the change is less than the item cost so an error is
      # raised
      expect{ machine.choose(:B,10.0) }.to change{machine.item_count(:B)}.by(-1)
    end
  end
end
