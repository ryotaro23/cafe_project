class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :time_id
      t.text :recommend_menu
      t.text :place
      t.integer :max_num

      t.timestamps
    end
  end
end
