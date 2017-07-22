Mutations::UpdateProject = GraphQL::Relay::Mutation.define do
  name 'UpdateProject'

  input_field :id, !types.ID

  mutator_definition = GraphQL::Models.define_mutator(
    self,
    Project,
    null_behavior: :leave_unchanged
  ) do
    attr :name
  end

  return_field :project, Types::ProjectInterface

  resolve ->(_obj, args, ctx) {
    record = Project.find(args[:id])
    mutator = mutator_definition.mutator(record, args, ctx)

    mutator.apply_changes
    mutator.validate!
    mutator.authorize!
    mutator.save!

    { project: record }
  }
end
