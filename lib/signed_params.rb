require "signed_params/concern"
require "signed_params/configuration"
require "signed_params/version"

module SignedParams
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
