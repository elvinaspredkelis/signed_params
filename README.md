# Signed Params

A lightweight library for encoding/decoding Rails request parameters.

`signed_params` are protected against tampering and safe to share with the internet. Great for generating sharable links and/or mitigating web scrapers.

Battle-tested at [Hansa](https://hansahq.com). Developed at [Primevise](https://primevise.com).

<a href="https://rubygems.org/gems/signed_params"><img alt="signed_params GEM Version" src="https://img.shields.io/gem/v/signed_params?color=10b981&include_prereleases&logo=ruby&logoColor=f43f5e"></a>
<a href="https://rubygems.org/gems/signed_params"><img alt="signed_params GEM Downloads" src="https://img.shields.io/gem/dt/signed_params?color=10b981&include_prereleases&logo=ruby&logoColor=f43f5e"></a>

---

## Installation

#### Add gem

Simply add the gem to your Gemfile by running the following command

```
bundle add signed_params
```

---

## Usage

The signed paramaters can be accesed via `params.signed`. It mirrors the behavior of Rails' [signed cookies](https://api.rubyonrails.org/classes/ActionDispatch/Cookies.html).

Similarly, setting a signed parameter can be done with the `params.sign` method.

#### Example

```ruby
class RecordsController < ApplicationController
  def index
    
    # Using `params.signed` will return `nil` if the parameter is tampered
    record_ids = params.signed[:record_ids]

    # Using `params.signed.fetch` will raise `ActionController::Parameters::InvalidSignature` if the parameter is tampered
    record_ids = params.signed.fetch(:record_ids)    

    @records = Record.find(record_ids)
  end

  def new_public_link
    record_ids = Record.last(8).pluck(:id)
    redirect_to records_path(params.sign(record_ids:))
  end
end
```

> [!TIP]
> You can use all sorts of datatypes when signing parameters. Strings, integers, arrays, objects - they all just work.

> [!CAUTION]
> Avoid exposing sensitive data while using `signed_params`. Your application should still implement proper authentication and authorization.

---

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
