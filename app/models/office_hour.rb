class OfficeHour < Event

  # max number of attendees is fixed to 1
  def max_attendees
    1
  end
end
