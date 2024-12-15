class TrainingAttendee < ApplicationRecord
  belongs_to :user
  belongs_to :user_membership

  def valid_for_training?
    if user_membership.status && user_membership.expiration_date >= Date.today
      if user_membership.subscription_type.name == "Carnet" || user_membership.subscription_type.name == "Entrée simple"
        check_booklet_entries
      elsif user_membership.subscription_type.name == "Abonnement mensuel" || user_membership.subscription_type.name == "Abonnement annuel"
        true
      else
        false
      end
    else
      false
    end
  end

  def check_booklet_entries
    if user_membership.entries_left > 0
      user_membership.update(entries_left: user_membership.entries_left - 1)
      true
    else
      false
    end
  end

  def register_for_training
    if valid_for_training?
      self.update(check: true)
    else
      raise "Abonnement non valide. Veuillez régulariser votre abonnement."
    end
  end
end
