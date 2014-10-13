# GritExt

grit_ext is a grit extension gem.

## Installation

Add this line to your application's Gemfile:

    gem 'grit_ext'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grit_ext

## Usage

```ruby
[1] pry(main)> require'grit'
=> true
[2] pry(main)> require'grit_ext'
=> true
```


################
cococode version:
since GritExt inherit Grit module and overwrite some methods to force_encoding 
those parameters to utf-8 formate. This will cause encoding problems whithin 
grit lib when calling those methods. 

This version of GritExt does not overwrite the grit's methods, instead, extend 
a new method utf8_xxx to supply utf8 encoding. 


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


