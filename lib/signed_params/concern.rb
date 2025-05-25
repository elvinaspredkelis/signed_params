module SignedParams
  module Concern
    extend ActiveSupport::Concern

    included do
      class_attribute :signed_param_keys, default: []
    end

    class_methods do
      def has_signed_params(*keys, **attributes)
        self.signed_param_keys = keys
        before_action :decode_signed_params
      end
    end

    private

    def sign_param(value)
      signed_params_verifier.generate(value)
    end

    def decode_signed_params
      return unless signed_param_keys.length
      signed_param_keys.each do |key|
        begin
          params[key] = signed_params_verifier.verify(params[key])
        rescue ActiveSupport::MessageVerifier::InvalidSignature
          params[key] = nil
        end
      end
    end

    def signed_params_verifier
      @signed_params_verifier ||= Rails.application.message_verifier(SignedParams.configuration.verifier_secret)
    end
  end
end
