class Coin
  attr_reader :value, :allowed_denominations

  def initialize
    @allowed_denominations = [1, 2, 5, 10, 20, 50, 100, 200]
  end

  def value=(amount)
    if !allowed_denominations.include?(amount)
      raise('Incorrect denomination for coin')
    end
  end
end
