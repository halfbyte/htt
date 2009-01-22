class CreateTrackings < ActiveRecord::Migration
  def self.up
    create_table :trackings do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.float :hours
      t.text :description
      t.integer :trackable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trackings
  end
end
