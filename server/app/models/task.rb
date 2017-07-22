class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, -> { order(created_at: :asc) }, dependent: :destroy
  has_one :user, through: :project

  acts_as_list scope: :project

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  validates :project, presence: true
end
