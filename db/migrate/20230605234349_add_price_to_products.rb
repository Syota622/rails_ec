# frozen_string_literal: true

class AddPriceToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price, :integer
  end
end
