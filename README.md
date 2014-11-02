# All Seeing Pi

The one gem to rule homemade Raspberry Pi surveillance systems. This gem will
capture images one after another and upload them to an S3 bucket.
## Installation

Add this line to your application's Gemfile:

    gem 'all_seeing_pi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install all_seeing_pi

## Usage

1. Setup a Raspberry Pi running NOOBS with a Raspberry Pi camera.
2. Set your AWS credentials by creating this file ~/.aws/credentials:
```
[default]
aws_access_key_id = your_access_key_id
aws_secret_access_key = your_secret_access_key
```
3. Install the gem and start capturing images with `rake watch`

## Contributing

1. Fork it ( http://github.com/1337807/all_seeing_pi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
