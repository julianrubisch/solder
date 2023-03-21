Solder.configure do |config|
  # Specify a global around action for Solder's UIStateController
  # This is useful for any assumptions your app makes, e.g. instance
  # variables being present, headers being checked, or multitenancy
  # (see example below)
  #
  # config[:around_action] = ->(_controller, action) do
  #   ActsAsTenant.without_tenant { action.call }
  # end
end
