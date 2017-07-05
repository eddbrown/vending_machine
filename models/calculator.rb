class Calculator
  ALLOWED_DENOMINATIONS = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]
  def initialize(cost, tender)
    @cost = cost
    @tender = tender
  end

  def difference
    @tender - @cost
  end

  def dispense_order
    order = {}
    remaining = difference
    ALLOWED_DENOMINATIONS.each do |d|
      order[d] = 0
    end

    until remaining == 0.0
      coin_value = ALLOWED_DENOMINATIONS.reverse.find {|d| d <= remaining}
      remaining = (remaining - coin_value).round(2)

      order[coin_value] += 1
    end

    order
  end
end
