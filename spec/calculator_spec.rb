require_relative '../models/calculator.rb'

RSpec.describe Calculator do
  it 'computes the difference between money in and the cost' do
    tender = 1
    cost = 0.75

    calc = Calculator.new(cost,tender)

    expect(calc.difference).to eq(0.25)
  end

  it 'works out the smallest amount of coins needed to return' do
    # I am not going to mathematically prove that it does this here but a few
    # examples will suffice
    tender = 1
    cost = 0.75

    calc = Calculator.new(cost,tender)

    expect(calc.compute_change).to eq(
      {
        0.01 => 0,
        0.02 => 0,
        0.05 => 1,
        0.1 => 0,
        0.2 => 1,
        0.5 => 0,
        1.0 => 0,
        2.0 => 0
      }
    )

    tender = 1
    cost = 0.81

    calc = Calculator.new(cost,tender)

    expect(calc.compute_change).to eq(
      {
        0.01 => 0,
        0.02 => 2,
        0.05 => 1,
        0.1 => 1,
        0.2 => 0,
        0.5 => 0,
        1.0 => 0,
        2.0 => 0
      }
    )
  end
end
