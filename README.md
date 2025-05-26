# Signed Params

A lightweight library for encoding/decoding Rails request parameters.

`signed_params` are protected against tampering and safe to share with the internet. Great for generating sharable links and/or mitigating web scrapers.

Battle-tested at [Hansa](https://hansahq.com). Developed at [Primevise](https://primevise.com).

<a href="https://rubygems.org/gems/signed_params">
  <img alt="signed_params GEM Version" src="https://img.shields.io/gem/v/signed_params?color=10b981&include_prereleases&logo=ruby&logoColor=f43f5e">
</a>

<a href="https://rubygems.org/gems/signed_params">
  <img alt="signed_params GEM Downloads" src="https://img.shields.io/gem/dt/signed_params?color=10b981&include_prereleases&logo=ruby&logoColor=f43f5e">
</a>

---

## Installation

#### Add gem

Simply add the gem to your Gemfile by running the following command

```bash
$ bundle add signed_params
```

#### Add to application

After you have the gem installed, you include the functionality in `app/controllers/application_controller.rb`:

```ruby
class ApplicationController < ActionController::Base
  include SignedParams::Concern
end
```

> [!TIP]
> You can also include the concern only in the controllers you seem fit. Adding the concern to the `ApplicationController` is a "forget about it" approach.

---

## Usage

You can encode your parameters with a `sign_param` helper method. Specify which params you want to decode by specifying them in the `has_signed_params` class method.

#### Example

```ruby
class RecordsController < ApplicationController
  has_signed_params :record_ids, only: :index

  def index
    # The record_ids param is automatically decoded
    @records = Record.find(params[:record_ids])
  end

  def new_public_link
    record_ids = Record.last(8).pluck(:id)
    encoded_record_ids = sign_params(record_ids)
    # Your controller action logic that generates shareable public links
  end
end
```

> [!CAUTION]
> Avoid exposing sensitive data while using `signed_params`. Your application should still implement proper authentication and authorization.

---

## Configuration

`signed_params` uses Rails' [ActiveSupport::MessageVerifier](https://api.rubyonrails.org/classes/ActiveSupport/MessageVerifier.html) under the hood to encode the params. You can adjust the secret used for encoding by adding an initializer.

```ruby
SignedParams.configure do |config|
  config.verifier_secret = ENV["SIGNED_PARAMS_ENCODING_SECRET"] || "my-strong-and-private-signing-secret"
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
