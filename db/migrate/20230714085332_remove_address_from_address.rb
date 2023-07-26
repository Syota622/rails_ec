# frozen_string_literal: true

class RemoveAddressFromAddress < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :country, :string
  end
end
