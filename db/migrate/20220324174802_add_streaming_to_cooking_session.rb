class AddStreamingToCookingSession < ActiveRecord::Migration[6.1]
  def change
    add_column :cooking_sessions, :streaming, :boolean
  end
end
