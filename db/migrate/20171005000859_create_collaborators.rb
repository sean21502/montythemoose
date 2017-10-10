class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.references :user
      t.references :wiki
      t.timestamps
    end
  end
end

