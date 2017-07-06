class Item
  attr_accessor :code

  COSTS = {
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

  def initialize(code)
    @code = code
  end
end
