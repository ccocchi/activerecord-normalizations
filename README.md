# ActiveRecord::Normalizations

`ActiveRecord::Normalizations` gives you the possibility to transform, or normalize, your attributes before they are saved in your database. It behaves mostly like validations, applying normalizations in methods like `save` or `update` but being totally skipped when methods touching directly the database like `update_columns`.

## Compatibility

### Ruby

Currently supported Ruby versions: MRI 2.5, 2.6, 2.7, 3.0.
JRuby hasn't been tested but since it's purely Ruby, it should work fine with it.

### Rails

Any version of ActiveRecord >= 4.2. It is tested against AR 5.2, 6.0, 6.1

## Installation

```ruby
gem 'activerecord-normalizations'
```

## Usage

`ActiveRecord::Normalizations` is included in `ActiveRecord::Base` by default so you can directly use the `normalize` method in your models:

```ruby
class User
  normalizes :firstname, spaces: true, text_transform: :capitalize
end
```

The first argument is the attribute you want to normalize, and each subsequent option are the normalizers that are going to me applied to it, each with their option (much like ActiveRecord'd validations).

## Normalizers

The gem comes with the following normalizers:

### Spaces

Available mode: `:leading, :trailing, :both (default)`

This normalizer removes leading, trailing or both spaces from your attribute. It uses Ruby's `strip` methods family under the hood.

### TextTransform

Available mode: `:capitalize, :lowercase, :uppercase, :word_capitalize`

This normalizer transforms your string attribute per the given mode:

* `capitalize`, `lowercase` and `uppercase` are pretty straight-forward and use Ruby's equivalent methods
* `word_capitalize` will capitalize every word of a string, a word being 1 or more alpha characters. Useful when dealing with foreign names like `Jean-Michel` or `O'Connor`.

## Custom Normalizer

You can also define your own normalizers. They should be classes following the naming format `<option_name>Normalizer`, initialized with an options hash and responding to the `call` method with a single argument, the attribute to normalize.

For example, if you wanted to reverse your attribute you could do create the following class

```ruby
# app/normalizers/reverse_normalizer.rb
class ReverseNormalizer
  def initialize(*args)
  end

  def call(attr)
    attr.reverse
  end
end
```

then use it in your model like any other normalizer

```ruby
# app/models/user.rb
class User < ApplicationRecord
  normalizes :name, reverse: true
end
```

You can check the [normalizers](https://github.com/ccocchi/activerecord-normalizations/tree/main/lib/activerecord-normalizations/normalizers) folder to see how included normalizers are done.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ccocchi/activerecord-normalizations. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveRecord::Normalizations project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ccocchi/activerecord-normalizations/blob/master/CODE_OF_CONDUCT.md).
