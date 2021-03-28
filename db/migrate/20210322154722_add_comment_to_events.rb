class AddCommentToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :comment, :text
    add_column :events, :store_url, :string
    add_column :events, :recommend_menu_price, :integer
    add_column :events, :date, :date
  end
end
