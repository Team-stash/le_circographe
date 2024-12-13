class NotepadsController < ApplicationController
  before_action :require_admin_or_godmode, only: [ :edit, :update ]
  include NotepadHelper
  def show
    @notepad = Rails.cache.fetch("notepad") || default_notepad
  end

  def edit
    @notepad = Rails.cache.fetch("notepad") || default_notepad
  end

  def update
    updated_notepad = params[:notepad]
    Rails.cache.write("notepad", updated_notepad)
    redirect_to notepad_path, notice: "Bloc-note mis à jour !"
  end

  private

  def require_admin_or_godmode
    unless Current.user.has_privileges?
      redirect_to root_path, alert: "Vous n'avez pas acces à cette page"
    end
  end
end