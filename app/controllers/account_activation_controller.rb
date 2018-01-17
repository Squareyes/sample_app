class AccountActivationController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user_activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activation_at, Time.zone.now)
      log_in user
      flash[:success] = "Account Activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
