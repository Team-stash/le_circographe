class Admin::DashboardController < ApplicationController
  ApplicationController
  before_action :authorize_admin_or_godmode

  def index
    @users = User.all
  end

  private

  def authorize_admin_or_godmode
    unless current_user&.role.in?(['admin', 'godmode'])
      redirect_to root_path, alert: 'Accès non autorisé'
    end
  end

end