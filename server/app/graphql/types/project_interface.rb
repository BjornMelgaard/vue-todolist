Types::ProjectInterface = GraphQL::ObjectType.define do
  name 'Project'

  backed_by_model :project do
    attr :id
    attr :name

    has_many_array :tasks
  end
end
