module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :events,
          [Types::EventType],
          null: false,
          description: 'Returns a list of events',
          resolver: Resolvers::EventsSearch

    def events
      # avoid N+1 queries on users
      Event.preload(:user).all
    end

    def self.authorized?(object, context)
      super && !context[:current_user].nil?
    end
  end
end
