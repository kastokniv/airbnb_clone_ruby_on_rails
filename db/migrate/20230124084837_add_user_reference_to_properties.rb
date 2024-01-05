class AddUserReferenceToProperties < ActiveRecord::Migration[7.0]
  def change
    add_reference :properties, :user, null: true, foreign_key: true
    user = User.first
    Property.update_all(user_id: user.id) if user.present?
  end
end
