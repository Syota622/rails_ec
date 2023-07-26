# frozen_string_literal: true

class AddPriceToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :price, :decimal
  end
end
