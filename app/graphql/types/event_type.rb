module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :type, String, null: true
    field :user, Types::UserType, null: false
    field :happens_on, Integer, null: true
    field :starts_at, Integer, null: true
    field :ends_at, Integer, null: true
    field :name, String, null: true
    field :location, String, null: true
    field :description, String, null: true
    field :max_attendees, Integer, null: true
    field :remaining_seats, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    # To avoid any timezone or parsing problem dates are expected
    # to be timestamps, in and out of the API.
    # Internally they are stored as UTC datetimes.

    def starts_at
      object.starts_at.to_i
    end

    def ends_at
      object.end_at.to_i
    end

    def happens_on
      object.happens_on.to_datetime.to_i
    end
  end
end
