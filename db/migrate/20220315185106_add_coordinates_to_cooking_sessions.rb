class AddCoordinatesToCookingSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :cooking_sessions, :address, :string
    add_column :cooking_sessions, :latitude, :float
    add_column :cooking_sessions, :longitude, :float
  end
end
