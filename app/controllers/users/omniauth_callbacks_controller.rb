class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.create_or_update_for_google_oauth2(request.env['omniauth.auth'], current_user)

    if @user && @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Google'
      # TODO: Remove this actually sign in
      session['devise.google_data'] = request.env['omniauth.auth']
      #sign_in_and_redirect @user, :event => :authentication
      redirect_to root_url
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      # redirect_to new_user_registration_url
      redirect_to root_url
    end
  end
end
