module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :type, String, null: true
    field :user, Types::UserType, null: false
    field :happens_on, GraphQL::Types::ISO8601Date, null: true
    field :starts_at, GraphQL::Types::ISO8601DateTime, null: true
    field :ends_at, GraphQL::Types::ISO8601DateTime, null: true
    field :name, String, null: true
    field :location, String, null: true
    field :description, String, null: true
    field :max_attendees, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
