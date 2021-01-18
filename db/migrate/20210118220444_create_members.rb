class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.string :url
      t.string :short_url

      t.timestamps
    end
  end
end
