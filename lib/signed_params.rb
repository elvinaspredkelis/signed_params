require "signed_params/version"
require "action_controller/metal/strong_parameters"

class ActionController::Parameters::Signed < Data.define(:verifier, :params)
  ActionController::Parameters::InvalidSignature = Class.new StandardError

  def [](key)
    verifier.verified(params[key])
  end

  def fetch(key)
    verifier.verify(params[key])
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    raise ActionController::Parameters::InvalidSignature
  end
end

module ActionController::Parameters::Signed::Integration
  def self.included(parameters)
    parameters.mattr_accessor :verifier
  end

  def sign(**params)
    params.transform_values { verifier.generate _1 }
  end
  def signed = @signed ||= ActionController::Parameters::Signed.new(verifier, self)
end

require_relative "signed_params/railtie" if defined?(Rails::Railtie)
