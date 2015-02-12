# ZapierRuby

[![Gem Version](https://badge.fury.io/rb/zapier_ruby.svg)](http://badge.fury.io/rb/zapier_ruby)

Zapier Ruby provides a simple wrapper to post a 'zap' to a Zapier (https://zapier.com) webhook from any Ruby application. You must first have a Zapier account and have created a webhook configured to 'catch hook'. This gem is useful for simple integrations, such as posting to slack when an event happens in your Rails app, or sending an email when your chef deploy has completed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zapier_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zapier_ruby

## Usage

### General Usage
First, configure ZapierRuby. Pass a hash of each of your zap webhooks you would like to integrate, you can also change the uri we post to or disable logging. Next, Instantiate a Zapper for the webhook to hit. Then, use the `zap` method with hash of params and send it to the Zapier web hook. `zap` returns true if it is able to successfully post the zap.

```
require 'rubygems'
require 'zapier_ruby'

ZapierRuby.configure do |c|
  c.web_hooks = {example_zap: "webhook_id"}
  c.enable_logging = false
end

zapper = ZapierRuby::Zapper.new(:example_zap)

if zapper.zap({hello: "world"})
  puts "zapped it"
else
 puts "it remains unzapped"
end
```

You can find the value to fill in for "webhook id" in the location highlighted below ('xxxxxx' in the green box) when configuring your Zap:

![](https://github.com/pete2786/pete2786.github.io/blob/master/images/finding_webhook.png)


Each param you send can be used by Zapier, so include all of the information required to complete the task.

### Rails Usage
If you are using ZapierRuby with Rails, I'd recommend using creating an initializer (ex. config/intializers/zapier_ruby.rb) and with the following:

```
ZapierRuby.configure.do |c|
  c.web_hooks = {example_zap: "zap_webhook_id"}
end
```

### Command Line Usage ###
To use this gem from the command line, you can leverage the `bin/zap` Ruby executable. In order to use this gem via command line, you must execute the gem in a folder which has a `.zapier_ruby.yml` file to configure your zaps. An example `.zapier_ruby.yml` file follows:

```
web_hooks:
  :example_zap: "xxxxxx"
enable_logging: false
```

You must pass `zap [zap_name] [Message]` to the executable. For example:
```
bundle exec zap example_zap "Hello, world."
```

Which will post {Message: "Hello, world"} to your web hook. The zap name must be configured in .zapier_ruby.yml the executable will error.

#### Example Usage

If you do not have email configured for you application, you could send an email via a Zap to notify a new user that their account has been created.
```
class User < ActiveRecord::Base
  after_create :welcome_new_user

  def welcome_new_user
    ZapierRuby::Zapper.new(:welcome_new_user).zap(user.attributes)
  end
end
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/zapier_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
