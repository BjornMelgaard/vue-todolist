Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root for this schema'

  field :project, function: Functions::FindRecordById.new(
    model: Project,
    type: Types::ProjectInterface
  )

  field :task, function: Functions::FindRecordById.new(
    model: Task,
    type: Types::TaskInterface
  )

  field :comment, function: Functions::FindRecordById.new(
    model: Comment,
    type: Types::CommentInterface
  )

  field :attachment, function: Functions::FindRecordById.new(
    model: Attachment,
    type: Types::AttachmentInterface
  )

  field :projects, types[Types::ProjectInterface] do
    resolve Resolvers::ProjectResolver.new ->(_, _, ctx) {
      # Pundit.policy_scope!(ctx[:current_user], Project)
      Project.all
    }
  end

  field :currentUser, Types::UserInterface do
    resolve ->(_obj, _args, ctx) {
      ctx[:current_user]
    }
  end
end
