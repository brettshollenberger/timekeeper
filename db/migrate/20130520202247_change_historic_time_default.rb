class ChangeHistoricTimeDefault < ActiveRecord::Migration
  def up
    change_column :launchers, :historic_time, :integer, :default => 0
  end

  def down
    change_column :launchers, :historic_time, :datetime
  end
end
