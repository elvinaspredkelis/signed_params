module SignedParams
  class Configuration
    attr_accessor :verifier_secret

    def initialize
      @verifier_secret = :signed_params
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
