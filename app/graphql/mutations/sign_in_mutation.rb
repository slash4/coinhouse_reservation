module Mutations
  class SignInMutation < GraphQL::Schema::Mutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    def resolve(email:, password:)
      user = User.find_by!(email: email).authenticate(password)
      return {errors: ["User not found"]} unless user

      token = JsonWebToken.encode({user_id: user.id, exp: 14.days.since.to_i}, 'coinhouse_reservation')
      {
        token: token,
        user: user
      }
    end
  end
end
