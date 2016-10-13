class Users::UnlinkController < ApplicationController
  def facebook
    @user = User.find(params[:id])
    @user.unlink_from_facebook
    flash[:success] = t "devise.omniauth_callbacks.unlinked"
    redirect_to edit_user_registration_path
  end
end
