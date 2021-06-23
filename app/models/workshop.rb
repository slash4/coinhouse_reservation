class Workshop < Event
  validates_presence_of :max_attendees

  def remaining_seats
    max_attendees - attendees.count
  end
end
