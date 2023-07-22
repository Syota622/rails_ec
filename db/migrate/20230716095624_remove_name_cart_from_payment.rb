# frozen_string_literal: true

class RemoveNameCartFromPayment < ActiveRecord::Migration[7.0]
  def change
    remove_column :payments, :name_cart, :string
  end
end
