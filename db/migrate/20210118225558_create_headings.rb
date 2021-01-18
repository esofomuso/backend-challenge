class CreateHeadings < ActiveRecord::Migration[5.1]
  def change
    create_table :headings do |t|
      t.integer :member_id
      t.string :kind
      t.string :name, null: false

      t.timestamps
    end

    add_index :headings, :name
  end
end
