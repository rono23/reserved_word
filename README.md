# ReservedWord

Make your reserved words on Rails.

For example, when you make a nickname is used example.com/nickname, you may validate some nicknames (e.g. about, faq etc). ReservedWord reserves a kind of words.

## Installation

Add this line to your application's Gemfile:

    gem 'reserved_word'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reserved_word

## Usage

```
# app/model/user.rb
before_validation { nickname.downcase! } # disable case sensitive if you want
validates :nickname, exclusion: { in: ReservedWord.list }

# Setup your reserved words on config/initializers/reserved_word.rb
ReservedWord.your_words = %w(foo bar)

# then use anywhere
ReservedWord.your_words.include?("foo") #=> true

# model
validates :nickname, exclusion: { in: ReservedWord.your_words }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
