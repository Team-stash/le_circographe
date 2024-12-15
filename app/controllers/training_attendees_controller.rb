class TrainingAttendeesController < ApplicationController
  def index
    @today_attendees = TrainingAttendee.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def new
    @training_attendee = TrainingAttendee.new
  end

  def create
    user = User.find(params[:user_id])
    user_membership = user.user_memberships.find_by(status: true)

    attendee = TrainingAttendee.new(user: user, user_membership: user_membership, check: false)

    begin
      attendee.register_for_training
      flash[:notice] = "Inscription réussie à la session d'entraînement."
      redirect_to training_sessions_path
    rescue => e
      flash[:alert] = e.message
      redirect_to training_sessions_path
    end
  end

  private

  def set_training_attendee
    @training_attendee = TrainingAttendee.find(params[:id])
  end
end
