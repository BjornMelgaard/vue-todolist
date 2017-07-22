Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutations'

  field :createProject,  field: Mutations::CreateProject.field
  field :updateProject,  field: Mutations::UpdateProject.field
  field :destroyProject, field: Mutations::DestroyProject.field
end
