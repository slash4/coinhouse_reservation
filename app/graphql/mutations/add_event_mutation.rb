module Mutations
  class AddEventMutation < Mutations::BaseMutation
    argument :user_id, Integer, required: true
    argument :type, String, required: true
    argument :description, String, required: false
    argument :location, String, required: true
    argument :name, String, required: true
    argument :max_attendees, Integer, required: false

    # To avoid any timezone or parsing problem dates are expected
    # to be timestamps, in and out of the API.
    # Internally they are stored as UTC datetimes.
    argument :happens_on, Integer, required: true
    argument :starts_at, Integer, required: true
    argument :ends_at, Integer, required: true

    field :event, Types::EventType, null: true
    field :errors, [String], null: false

    def resolve(user_id:, type:, description:, location:, name:, max_attendees: nil, happens_on:, starts_at:, ends_at:)

      user = User.find(user_id)
      if user.nil?
        raise GraphQL::ExecutionError,
              "You need to select an actual user"
      end

      event = Event.new(
        type: type,
        user: user,
        happens_on: Time.at(happens_on),
        starts_at: Time.at(starts_at),
        ends_at: Time.at(ends_at),
        description: description,
        name: name,
        location: location,
        max_attendees: max_attendees,
      )

      if event.save
        { event: event, errors: []}
      else
        { errors: event.errors.full_messages }
      end
    end
  end
end
