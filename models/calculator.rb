class Calculator
  ALLOWED_DENOMINATIONS = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0]
  def initialize(cost, tender)
    @cost = cost
    @tender = tender
    @change = {}
    ALLOWED_DENOMINATIONS.each do |d|
      @change[d] = 0
    end
  end

  def difference
    @tender - @cost
  end

  def compute_change
    remaining = difference

    until remaining == 0.0
      coin_value = ALLOWED_DENOMINATIONS.reverse.find {|d| d <= remaining}
      remaining = (remaining - coin_value).round(2)

      @change[coin_value] += 1
    end

    @change
  end
end
