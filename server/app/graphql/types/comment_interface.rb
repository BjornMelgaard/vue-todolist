Types::CommentInterface = GraphQL::ObjectType.define do
  name 'Comment'

  backed_by_model :comment do
    attr :id
    attr :text

    has_many_array :attachments
  end
end
