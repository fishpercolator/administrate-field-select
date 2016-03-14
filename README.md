# Administrate::Field::Select

Adds basic select/dropdown fields to ThoughtBot's [Administrate](https://github.com/thoughtbot/administrate)

[![Gem Version](https://img.shields.io/gem/v/administrate-field-select.svg?style=flat)](https://rubygems.org/gems/administrate-field-select)
[![Build Status](https://img.shields.io/travis/fishpercolator/administrate-field-select/master.svg?style=flat)](https://travis-ci.org/fishpercolator/administrate-field-select)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate-field-select'
```

And then execute:

    $ bundle

## Usage

In your dashboard's `ATRRIBUTE_TYPES`, use the type `Field::Select` with options:

```ruby
ATTRIBUTE_TYPES = {
  my_field: Field::Select.with_options({
    choices: ['option_one', 'option_two', 'option_three']
  }),
  some_other_field: Field::String,
}
```

The options specified in `choices` will be passed as the choice to a Rails [`select`](http://api.rubyonrails.org/classes/ActionView/Helpers/FormBuilder.html#method-i-select) tag.

Additional options that are available:

* `include_blank`: If true or a string, includes a blank option in the dropdown (with the string as its text).
* `prettify`: If true, passes all choices through [`titleize`](http://api.rubyonrails.org/classes/String.html#method-i-titleize) before displaying them (in all views). If a lambda, that lambda is used instead of `titleize`.

## Todo

Some ideas for possible enhancements:

1. Support i18n instead of prettify
2. Be more magic with enum types and reflect the choices

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fishpercolator/administrate-field-select. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

