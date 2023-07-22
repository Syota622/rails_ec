# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.string :card_name
      t.string :name_cart
      t.string :credit_number
      t.string :expiration
      t.string :cvv

      t.timestamps
    end
  end
end
