class SignedParams::Railtie < Rails::Railtie
  initializer "parameters.signed.set_verifier" do |app|
    ActionController::Parameters.include ActionController::Parameters::Signed::Integration
    ActionController::Parameters.verifier = app.message_verifier :signed_parameters
  end
end
