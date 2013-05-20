# Kango

Wrapper and task runner for the [Kango Framework](http://kangoextensions.com)

Thanks to the folks @ Kango Framework!

## Installation

Make sure you have python. Kango Framework is written in python.
This gem calls python directly, so make sure it's in your PATH.

Add this line to your application's Gemfile:

    gem 'kango'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kango

## Usage

`kango docs` will take you to http://kangoextensions.com/docs/index.html

`kango install` will download and install kango framework into your home directory

`kango create` wraps kango's create command, ready for coffeescript via this gem

`kango build` will compile your coffeescript and use KangoFramework to build 

## Example

```bash
gem install kango         # install the gem
kango install             # install the kango framework into ~/kango-framework
kango create adblock      # generate a new browser extension called adblock
cd adblock
bundle                    # bundle this gem so you can build
vim coffee/main.coffee    # write coffeescript here!
kango build               # compile the coffeescript and build with the Kango Framework
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
