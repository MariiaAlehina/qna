Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  admin_authenticator do
      current_user.try(:admin) || redirect_to(new_user_session_path)
  end

  authorization_code_expires_in 2.hours

  # Access token expiration time (default 2 hours).
  # If you want to disable expiration, set this to nil.
  #
  access_token_expires_in 24.hours

  api_only
end
