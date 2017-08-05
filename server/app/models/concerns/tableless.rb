module Tableless
  extend ActiveSupport::Concern
  include ActiveModel::Model

  class_methods do
    def has_many(name, **options)
      through = options.delete :through
      define_method name do
        if through
          send(name).send(through)
        else
          name.camelize.constantize.where(user_id: id)
        end
      end
    end
  end
end
