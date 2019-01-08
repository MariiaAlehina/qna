class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    respond_with current_user_owner
  end
end