class Users::CallbacksController < Devise::OmniauthCallbacksController
  class << self
    def provides_callback_for provider
      class_eval %Q{
        def #{provider}
          @user = User.from_omniauth request.env["omniauth.auth"]
          if @user.persisted?
            flash[:success] = t("devise.omniauth_callbacks.success",
              kind: "#{provider}".capitalize)
            if @user.encrypted_password.blank?
              flash[:warning] = t "devise.omniauth_callbacks.no_password_set"
            end
            sign_in_and_redirect @user
          else
            if current_user
              auth = request.env["omniauth.auth"]
              current_user.link_with_facebook auth.provider, auth.uid
              flash[:success] = t "devise.omniauth_callbacks.linked"
              redirect_to edit_user_registration_path
            else
              session["devise.user_attributes"] = @user.attributes
              flash[:notice] = t "devise.omniauth_callbacks.complete_registration"
              redirect_to new_user_registration_path
            end
          end
        end
      }
    end
  end

  [:facebook].each do |provider|
    provides_callback_for provider
  end
end
