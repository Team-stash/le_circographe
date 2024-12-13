require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  def setup
    @event = events(:one) # Assurez-vous qu'un événement existe
  end

  test "visiting the event page" do
    visit event_path(@event)
    assert_selector "h1", text: @event.title
    assert_button "Payer 10€"
  end
end
