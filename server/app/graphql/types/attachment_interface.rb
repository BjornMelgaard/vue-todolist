Types::AttachmentInterface = GraphQL::ObjectType.define do
  name 'Attachment'

  backed_by_model :attachment do
    attr :id
    attr :file
  end
end
