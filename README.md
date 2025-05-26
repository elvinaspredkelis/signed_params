# Signed Params

A small Rails controller concern that allows encoding and decoding parameters. Such parameters are protected against tamparing and safe to share with the internet.

Battle tested at [Hansa](https://hansahq.com)

Developed at [Primevise](https://primevise.com)

---

## Installation

#### Add gem

Simply add the gem to your Gemfile by running the following command

```bash
$ bundle add signed_params
```

---

#### Add it to your application

After you have the gem installed, you include the functionality in `app/controllers/application_controller.rb`:

```ruby
class ApplicationController < ActionController::Base
  include SignedParams::Concern
  # ...
end
```

> [!TIP]
> You can also include the concern only in the controllers you seem fit. Adding the concern to the `ApplicationController` is a "forget about it" approach.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
