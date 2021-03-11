class CreateTimeTables < ActiveRecord::Migration[6.1]
  def change
    create_table :time_tables do |t|
      t.text :time

      t.timestamps
    end
  end
end
