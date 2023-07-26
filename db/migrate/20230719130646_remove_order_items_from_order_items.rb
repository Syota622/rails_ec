# frozen_string_literal: true

class RemoveOrderItemsFromOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_items, :price, :decimal
  end
end
