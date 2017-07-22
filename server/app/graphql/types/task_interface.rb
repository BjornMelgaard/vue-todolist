Types::TaskInterface = GraphQL::ObjectType.define do
  name 'Task'

  backed_by_model :task do
    attr :id
    attr :name
    attr :done
    attr :deadline
    attr :position

    has_many_connection :comments
  end
end
