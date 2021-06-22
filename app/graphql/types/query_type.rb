module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :events,
          [Types::EventType],
          null: false,
          description: "Returns a list of events"

    def events
      #avoid N+1 queries on users
      Event.preload(:user).all
    end
  end
end
