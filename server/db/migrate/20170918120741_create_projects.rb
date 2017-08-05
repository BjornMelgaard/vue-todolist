class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name

      t.integer :user_id
      t.index ['user_id'], name: 'index_projects_on_user_id'

      t.timestamps
    end
  end
end
