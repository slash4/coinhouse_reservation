module Types
  class MutationType < Types::BaseObject
    field :add_event, mutation: Mutations::AddEventMutation
    field :add_attendee, mutation: Mutations::AddAttendeeMutation
    field :delete_attendee, mutation: Mutations::DeleteAttendeeMutation
    field :sign_in, mutation: Mutations::SignInMutation
  end
end
