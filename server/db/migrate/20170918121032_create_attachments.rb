class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.string :file

      t.belongs_to :comment

      t.timestamps
    end
  end
end
