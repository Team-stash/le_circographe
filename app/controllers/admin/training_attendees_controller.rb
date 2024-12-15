module Admin
  class TrainingAttendeesController < ApplicationController
    def index
      @today_attendees = TrainingAttendee.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    end

    def new
      @training_attendee = TrainingAttendee.new
    end

    def create
      user = User.find_by(id: training_attendee_params[:user_id])
      user_membership = user&.user_memberships&.find_by(id: training_attendee_params[:user_membership_id])

      if user.nil? || user_membership.nil?
        flash[:alert] = "Utilisateur ou abonnement non valide."
        redirect_to admin_training_attendees_path and return
      end

      @training_attendee = TrainingAttendee.new(user: user, user_membership: user_membership)

      if @training_attendee.save
        redirect_to admin_training_attendees_path, notice: "Ajouté à la liste d'entraînement avec succès."
      else
        flash[:alert] = "Erreur lors de l'ajout à la liste d'entraînement."
        render :new, status: :unprocessable_entity
      end
    end

    # private

    # def training_attendee_params
    #   params.require(:training_attendee).permit(:user_id, :user_membership_id)
    # end
  end
end
