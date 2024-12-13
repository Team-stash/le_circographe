require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one) # Remplacez par un utilisateur défini dans vos fixtures
    @event = events(:one) # Assurez-vous qu'un événement existe
    sign_in(@user) # Méthode personnalisée pour simuler une session
  end

  test "should create a Stripe session" do
    post checkout_create_path, params: { event_id: @event.id }
    assert_response :redirect
    assert_redirected_to /checkout\.stripe\.com/ # Vérifie si on redirige bien vers Stripe
  end

  test "should redirect to success on successful payment" do
    get checkout_success_path, params: { session_id: "fake_session_id", event_id: @event.id }
    assert_response :redirect
    assert_redirected_to event_path(@event)
  end
end