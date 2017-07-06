class Machine
  ALLOWED_DENOMINATIONS = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]
  MAX_ITEM_CAPACITY = 10
  MAX_COIN_CAPACITY = 100

  def initialize
    @items = []
    @coins = []
  end

  def item_count(code)
    @items.select{|i| i.code == code}.size
  end

  def coin_count(denomination)
    @coins.select{|c| c == denomination}.size
  end

  def add_coin(denomination)
    @coins.push(denomination)
  end

  def dispense_coin(denomination)
    @coins.delete_at(@coins.find_index{|c| c == denomination})
  end

  def dispense_item(code)
    @items.delete_at(@items.find_index{|i| i.code == code})
  end

  def reload_items
    @items = []

    Item::COSTS.each do |code, _|
      MAX_ITEM_CAPACITY.times {
        item = Item.new(code)

        @items.push(item)
      }
    end
  end

  def reload_coins
    @coins = []

    ALLOWED_DENOMINATIONS.each do |denomination|
      MAX_COIN_CAPACITY.times {
        add_coin(denomination)
      }
    end
  end

  def compute_change(cost, tender)
    raise('Insufficient Funds') if (cost > tender)

    Calculator.new(cost, tender).compute_change
  end

  def choose(item, tender)
    item_cost = Item::COSTS[item]
    change_list = compute_change(item_cost, tender)

    dispensed_change = []

    change_list.each do |coin, number|
      number.times{
        change = dispense_coin(coin)
        dispensed_change.push(change)
      }
    end

    {
      item: dispense_item(item),
      change: dispensed_change
    }
  end

  def empty
    @items = []
    @coins = []
  end
end
