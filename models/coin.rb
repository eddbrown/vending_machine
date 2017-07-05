class Coin
  attr_reader :value, :allowed_denominations

  def initialize
    @allowed_denominations = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]
  end

  def value=(amount)
    @value = amount
    if !allowed_denominations.include?(amount)
      raise('Incorrect denomination for coin')
    end
  end
end
