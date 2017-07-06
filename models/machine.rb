class Machine
  ALLOWED_DENOMINATIONS = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]
  ITEM_CODES = [:A,:B,:C,:D,:E,:F,:G,:H,:I,:J]
  ITEM_COSTS = {
    A: 1.0,
    B: 1.0,
    C: 1.0,
    D: 1.0,
    E: 1.0,
    F: 1.0,
    G: 1.0,
    H: 1.0,
    I: 1.0,
    J: 1.0,
  }
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

    ITEM_CODES.each do |code|
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

  def compute_change(item, tender)
    raise('Insufficient Funds') if (ITEM_COSTS[item.to_sym] > tender)

    Calculator.new(ITEM_COSTS[item], tender).compute_change
  end

  def choose(item, tender)
    change_list = compute_change(item, tender)

    dispensed_change = []

    change_list.each do |coin, number|
      number.times{
        dispensed_change.push(dispense_coin(coin))
      }
    end

    {
      item: dispense_item(item),
      change: dispensed_change
    }
  end
end
