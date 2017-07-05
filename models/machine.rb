require 'pry'
class Machine
  ALLOWED_DENOMINATIONS = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]
  ITEM_CODES = ['A','B','C','D','E','F','G','H','I','J']
  MAX_ITEM_CAPACITY = 10
  MAX_COIN_CAPACITY = 10

  def initialize
    @items = []
    @coins = []
  end

  def item_count(code)
    @items.select{|c| c.code == code}.size
  end

  def coin_count(denomination)
    @coins.select{|c| c.value == denomination}.size
  end

  def add_coin(denomination)
    coin = Coin.new
    coin.value = denomination

    @coins.push(coin)
  end

  def dispense_coin(denomination)
    @coins.delete_at(@coins.find_index{|c| c.value == denomination})
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
end
