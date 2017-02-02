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
rescue ArgumentError => e
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
```ruby
require 'metrorb'

original =   [1, 1, 0, 0, 0]
prediction = [1, 1, 1, 1, 1]

calc = Metrorb::Calculate.from_arrays(original, prediction)
calc.acc # => 0.4
```

See below a list with the implemented metrics.

### Working with CSV files

This gem can also deal directly with csv files that contains the original and prediction data. The workflow is similar to working with arrays.

The expected csv files must have only 2 columns: one with an identifier and other with the value.

By default it will expect the columns headers to be "id" and "value".

For instance, this is a valid csv file:
```
id,value
1,2
2,3
3,5
4,7
5,11
```

To calculate a metric you will need two csv files like the one showed above: one with the original data and one with the prediction data.

The `Calculate` object will pass the two first parameters down to the standard CSV ruby library, so it accepts either a string or an IO object.

Here is some code with basic usage:

```ruby
require 'metrorb'

orig_csv = File.open("my/data/path/orig.csv")
pred_csv = File.open("my/data/path/pred.csv")

calc = Metrorb::Calculate.from_csvs(orig_csv, pred_csv)
calc.mae # => 4.4
```

If your csv have custom labels for the id and/or value you can specify them passing some options to the `from_csvs`:
```ruby
calc = Metrorb::Calculate.from_csvs(orig_csv, pred_csv, id: :custom_identifer, value: :custom_value_label)
```

The code above will expect a csv file like this:
```
custom_identifer,custom_value_label
1,2
2,3
3,5
4,7
5,11
```

The `from_csvs` method will ignore trailing spaces, expect all the rows (except the header) to be numeric and apply some transformations to the header labels:

> The header String is downcased, spaces are replaced with underscores, non-word characters are dropped, and finally to_sym() is called.

This is done with the [:symbol HeaderConverter](http://ruby-doc.org/stdlib-2.4.0/libdoc/csv/rdoc/CSV.html#HeaderConverters) from ruby CSV standard library.

This makes the `from_csvs` method more permissive and ignore small formating errors. The following headers are treated equally:
```
custom_identifer,custom_value_label
Custom Identifier, Custom Value label
   custom identIfier, custom vaLue Label
```

If the prediction csv file don't contain all the ids from the original dataset csv file, the `from_csvs` method will raise an error. You can check which ids are missing when you rescue the error:
```ruby
require 'metrorb'

orig_csv = File.open("my/data/path/orig.csv")
pred_csv = File.open("my/data/path/pred.csv")

begin
  calc = Metrorb::Calculate.from_csvs(orig_csv, pred_csv)
rescue Metrorb::BadCsvError => e
  puts e.ids    # => [1, 2, 3]
  puts e.to_s   # => Missing IDs in the prediction csv: [1, 2, 3]
end
```

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

## TODO

* Treat case where csv have more/wrong columns
* Add info in the README about I18n.
* Add info in the README about Metrorb helper methods
* Generate some docs
* Publish 0.1 to rubygems
