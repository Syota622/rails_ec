# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :order, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :email_name
      t.string :address1
      t.string :address2
      t.string :country
      t.string :prefectures
      t.string :post_code

      t.timestamps
    end
  end
end
