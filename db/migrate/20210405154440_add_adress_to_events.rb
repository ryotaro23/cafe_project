class AddAdressToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :adress, :text
  end
end
