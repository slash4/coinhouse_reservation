module Types
  class MutationType < Types::BaseObject
    field :add_event, mutation: Mutations::AddEventMutation
    field :sign_in, mutation: Mutations::SignInMutation
  end
end
