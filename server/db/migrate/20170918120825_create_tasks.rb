class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.boolean    :done
      t.string     :name
      t.timestamp  :deadline
      t.integer    :position

      t.belongs_to :project

      t.timestamps
    end
  end
end
