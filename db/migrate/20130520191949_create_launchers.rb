class CreateLaunchers < ActiveRecord::Migration
  def change
    create_table :launchers do |t|
      t.string :name
      t.datetime :historic_time
      t.datetime :in_time
      t.integer :checkins
      t.string :in

      t.timestamps
    end
  end
end
