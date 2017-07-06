# Vending Machine

This github repository contains my answer to the vending machine tech test.

## Specs
There are two spec folders, integration and unit. The integration tests are
for two fold reasons:

* Provide integration testing where no models are stubbed out
* Answer specifically the aims of the brief in test form

The unit tests provide modular testing with stubbing.

## Models
For the purposes of this test, only three models were eventually created:
* Machine
* Calculator
* Item

The machine class handles the overall task of dispensing items and providing
change given an item code and an entered amount of money. It delegates its
change calculation logic to the calculator class. There is also a class for the
individual items in the machine. This might perhaps be overkill given how
simple the class was, all they need are a code and a cost.

## Use
The brief questions are answered in the integration spec, but if you want to
properly check that it is working and to play around with the machine to test
its functionality, simply enter `irb` in the command line and require the three
classes.

e.g `require "~/your_folder/machine.rb"`

then instantiate a machine object:

`machine = Machine.new`

The codes for the items are given by the symbols :A through to :J

The denominations are [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0, 2.0].
These are just the British coin denominations in terms of their
pound value.

The main methods to use on machine are:

```ruby
machine.choose(item_code, tender)
machine.item_count(code)
machine.coin_count(denomination)
machine.reload
```

These methods are detailed in the specs.
