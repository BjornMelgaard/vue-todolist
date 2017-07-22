ApplicationSchema = GraphQL::Schema.define do
  query    Types::QueryType
  mutation Mutations::MutationType

  # Set up the graphql-batch gem
  lazy_resolve(Promise, :sync)
  instrument(:query, GraphQL::Batch::Setup)

  # Set up the graphql-activerecord gem
  instrument(:field, GraphQL::Models::Instrumentation.new)

  # in graphql status code always must be 200
  rescue_from ActiveRecord::RecordInvalid,   &:message
  rescue_from ActiveRecord::Rollback,        &:message
  rescue_from StandardError,                 &:message
  rescue_from ActiveRecord::RecordNotUnique, &:message
  rescue_from ActiveRecord::RecordNotFound,  &:message
  rescue_from Errors::Unauthenticated,       &:message
  rescue_from Pundit::NotAuthorizedError do |e|
    action     = e.query.to_s.delete('?')
    model_name = e.record.model_name
    "not allowed to #{action} this #{model_name}"
  end
end
