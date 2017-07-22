Mutations::CreateProject = GraphQL::Relay::Mutation.define do
  name 'CreateProject'

  mutator_definition = GraphQL::Models.define_mutator(
    self,
    Project,
    null_behavior: :set_null
  ) do
    attr :name
  end

  return_field :project, Types::ProjectInterface

  resolve ->(_obj, args, ctx) {
    record = Project.new(user: ctx[:current_user])
    mutator = mutator_definition.mutator(record, args, ctx)

    mutator.apply_changes
    mutator.validate!
    mutator.authorize!
    mutator.save!

    { project: record }
  }
end
