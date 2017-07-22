module Functions
  class FindRecordById < GraphQL::Function
    def initialize(model:, type:)
      @model = model
      @type = type

      @description = "Find a #{model.model_name} by id"
    end

    attr_reader :type
    attr_reader :description

    argument :id, !types.ID

    def call(_object, arguments, ctx)
      record = model.find(arguments['id'])

      # Pundit authorization
      Pundit.authorize(ctx[:current_user], record, :show?)

      record
    end

    private

    attr_reader :model
  end
end
