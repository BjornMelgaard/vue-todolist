Types::UserInterface = GraphQL::ObjectType.define do
  name 'User'
  description 'Represents user'

  field :id, !types.ID
end
