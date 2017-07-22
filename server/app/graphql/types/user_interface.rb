Types::UserInterface = GraphQL::ObjectType.define do
  name 'User'
  description 'Represents user'

  backed_by_model :user do
    attr :id
    attr :email
  end
end
