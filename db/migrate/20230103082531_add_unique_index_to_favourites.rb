class AddUniqueIndexToFavourites < ActiveRecord::Migration[7.0]
  def change
    add_index :favourites, %i[property_id user_id], unique: true
  end
end
