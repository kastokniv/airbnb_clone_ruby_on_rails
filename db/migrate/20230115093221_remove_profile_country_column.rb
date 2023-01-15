# frozen_string_literal: true

class RemoveProfileCountryColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :profiles, :country
  end
end
