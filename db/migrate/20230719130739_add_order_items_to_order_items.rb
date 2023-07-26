# frozen_string_literal: true

class AddOrderItemsToOrderItems < ActiveRecord::Migration[7.0]
  def change
    change_table :order_items, bulk: true do |t|
      t.string :name
      t.integer :price
    end
  end
end
