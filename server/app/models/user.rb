class User
  include Tableless

  attr_accessor :id

  has_many :projects
  has_many :tasks,       through: :projects
  has_many :comments,    through: :tasks
  has_many :attachments, through: :comments

  def self.from_token_payload(payload)
    id = payload['sub']

    raise Knock.not_found_exception_class_name if id.nil?
    User.new(id: id)
  end
end
