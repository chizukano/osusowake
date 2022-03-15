class CreateCookingSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :cooking_sessions do |t|
      t.integer :max_portions
      t.datetime :start_at
      t.datetime :end_at
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
