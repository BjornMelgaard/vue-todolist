# Database types extensions
Types::TextType = GraphQL::ScalarType.define do
  name 'TEXT'
  coerce_input ->(x, _context) { x }
  coerce_result ->(x, _context) { x }
end

Types::DateTimeType = GraphQL::ScalarType.define do
  name 'DATETIME'
  coerce_input ->(x, _context) { x }
  coerce_result ->(x, _context) { x.to_s(:api) }
end

GraphQL::Models::DatabaseTypes.register(:datetime, Types::DateTimeType)
GraphQL::Models::DatabaseTypes.register(:text, Types::TextType)

# Pundit authorization
GraphQL::Models.authorize = lambda { |ctx, action, record|
  # Action will be either :create, :update, or :destroy
  Pundit.authorize(ctx[:current_user], record, "#{action}?")
}

# Use namespaced Types::ModelNameType by default for association types
GraphQL::Models.model_to_graphql_type = lambda { |model_class|
  "Types::#{model_class.name}Interface".safe_constantize
}
