# Metrorb
[![Build Status](https://travis-ci.org/oesgalha/metrorb.svg?branch=master)](https://travis-ci.org/oesgalha/metrorb)
[![Code Climate](https://codeclimate.com/github/oesgalha/metrorb/badges/gpa.svg)](https://codeclimate.com/github/oesgalha/metrorb)
[![Test Coverage](https://codeclimate.com/github/oesgalha/metrorb/badges/coverage.svg)](https://codeclimate.com/github/oesgalha/metrorb/coverage)

**MET**rics er**RO**r for **R**u**B**y

Metrorb is ruby gem (library) with a collection of statistics error metrics.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metrorb', git: 'https://github.com/oesgalha/metrorb.git'
```

And then execute:

    $ bundle

## Usage

To calculate any error metrics the first thing to do is instantiate a `Calculate` object, you can feed this object with arrays or csv files.
The first parameter is the original data, the second one is the predicted data.

### Working with arrays

The example below will successfully instantiate a `Calculate` object:
```ruby
require 'metrorb'

original =   [44, 17, 33, 21, 57]
prediction = [48, 12, 35, 28, 53]

calc = Metrorb::Calculate.from_arrays(original, prediction)
```

Note that if the arrays don't have the same size, the `#from_arrays` method will raise an `ArgumentError`:
```ruby
require 'metrorb'

original =   [44, 17, 33]
prediction = [48, 12, 35, 28, 53]

begin
  calc = Metrorb::Calculate.from_arrays(original, prediction)
rescue e => ArgumentError
  puts e.to_s # => The original and prediction arrays must have the same size!
end
```

Back to the happy path: with the `Calculate` object call the method to calculate the desired error metric. Sample with the _Mean Absolute Error_:
```ruby
require 'metrorb'

original =   [44, 17, 33, 21, 57]
prediction = [48, 12, 35, 28, 53]

calc = Metrorb::Calculate.from_arrays(original, prediction)
calc.mae # => 4.4
```

Another example, with ``Accuracy``:


See below a list with the implemented metrics.

### Working with CSV files

This gem can also deal directly with csv files that contains the original and prediction data. The workflow is similar to working with arrays.

TODO: continue csv doc

### Available Metrics

|Metric name        |method|alias                |
|-------------------|------|---------------------|
|Accuracy           |`acc` |`accuracy`           |
|Mean Absolute Error|`mae` |`mean_absolute_error`|

## Development

This gem has no dependecies. Use `rake` to run tests and hack away.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/oesgalha/metrorb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
