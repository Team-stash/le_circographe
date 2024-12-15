module Admin
  class MembershipsController < ApplicationController





    private

    def user_membership_params
      params.require(:user_membership).permit(:first_name, :last_name, :email_address, :birthdate, :address, :city, :postal_code, :subscription_type_id, :membership_fee, :newsletter, :get_involved, :is_member, :payment_method)
    end
  end
end
