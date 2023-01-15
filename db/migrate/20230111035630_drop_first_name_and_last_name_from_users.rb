# frozen_string_literal: true

class DropFirstNameAndLastNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
