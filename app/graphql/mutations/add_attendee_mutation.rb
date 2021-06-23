module Mutations
  class AddAttendeeMutation < Mutations::BaseMutation
    argument :event_id, Integer, required: true

    field :attendee, Types::AttendeeType, null: true
    field :errors, [String], null: true

    def resolve(event_id:)

      # Request isn't authenticated
      if context[:current_user].nil?
        raise GraphQL::ExecutionError,
              "You need to be registered to do that"
      end

      attendee = Attendee.new(
        event_id: event_id,
        user_id: context[:current_user].id,
      )

      if attendee.save
        { attendee: attendee }
      else
        { errors: attendee.errors.full_messages }
      end
    end
  end
end
