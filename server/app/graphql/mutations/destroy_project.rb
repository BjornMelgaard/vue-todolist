Mutations::DestroyProject = GraphQL::Relay::Mutation.define do
  name 'DestroyProject'
  description 'Destroy a Project by id'

  input_field :id, !types.ID

  return_field :project, Types::ProjectInterface

  resolve ->(_obj, args, ctx) {
    record = Project.find(args[:id])

    Pundit.authorize(ctx[:current_user], record, :destroy?)

    { project: record }
  }
end
