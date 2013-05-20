class ChangeColumnDefaults < ActiveRecord::Migration
  def up
    change_column :launchers, :in, :string, :default => 'f'
    change_column :launchers, :checkins, :integer, :default => 0
  end

  def down
    change_column :launchers, :in, :string
    change_column :launchers, :checkins, :integer
  end
end
