class AddOrderItemsToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :name, :string
    add_column :order_items, :price, :integer
  end
end
