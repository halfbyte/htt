class CreateTrackables < ActiveRecord::Migration
  def self.up
    create_table :trackables do |t|
      t.string :name
      t.string :permalink
      t.integer :parent_id
      t.boolean :billable

      t.timestamps
    end
  end

  def self.down
    drop_table :trackables
  end
end
