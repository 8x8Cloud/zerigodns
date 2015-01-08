# Zerigo DNS GEM

Simple ActiveResource wrapper around the [Zerigo DNS REST API](https://www.zerigo.com/docs/apis/dns/1.1)



## Install

    gem install zerigodns
    
## How to use

```ruby
require 'zerigodns'
    
Zerigo::DNS::Base.user = 'you@email.com'
Zerigo::DNS::Base.api_key = 'yourtokengoeshere'
    
# Find or create domain
my_zone = Zerigo::DNS::Zone.find_or_create('happyplace.com')
    
# update or create host record
my_host = Zerigo::DNS::Host.update_or_create(my_zone, 'www', 'A', 86400, '10.10.10.10')
```

Thats it, you should now have a host and url www.happyplace.com pointing to 10.10.10.10


## How to test

    `bundle exec rspec`

### Running the feature tests

These test the gem's interaction with the live product to verify interactions through the gem work as advertised on the latest production version of zerigo dns.

These tests require an actual API key and account.  After you create an account and api key, create the file `spec/config/user.yml`:

```yaml
user: you@email.com
api_key: yourtokengoeshere
secure: yes
```


Running `bundle exec rspec` will also run the end-to-end test suite.

## Contributors

* Thank you to Tom Wilson ([github.com/twilson63](http://github.com/twilson63)) for creating the `zerigo_dns` gem on which this product is based.

* Thank you to John Axel Eriksson ([github.com/johnae](http://github.com/johnae)) for adding secure option and default, for the Zerigo DNS API.

* Thank you to Anthony Scalisi
([github.com/scalp42](https://github.com/scalp42)) for requesting api change: self.api_key instead self.password


## How to get Support

[https://github.com/8x8Cloud/zerigo_dns](https://github.com/8x8Cloud/zerigo_dns)
    
Create an issue

## Copyright

    Copyright 2009 Zerigo, Inc.  See LICENSE for license information.

    Copyright (c) 2009 Tom Wilson

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
