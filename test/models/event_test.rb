require "test_helper"

class EventTest < ActiveSupport::TestCase
  def setup
    @event = Event.new(
      title: "Test Event",
      upper_description: "Upper description",
      location: "Paris",
      date: Time.now + 1.day,
      creator_id: User.first.id # Assurez-vous qu'un utilisateur existe dans vos fixtures
    )
  end

  test "should be valid with all attributes" do
    assert @event.valid?
  end

  test "should be invalid without a title" do
    @event.title = nil
    assert_not @event.valid?
  end

  test "should be invalid with past date" do
    @event.date = Time.now - 1.day
    assert_not @event.valid?
  end
end
