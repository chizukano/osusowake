class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :portion_count
      t.references :user, null: false, foreign_key: true
      t.references :cooking_session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
