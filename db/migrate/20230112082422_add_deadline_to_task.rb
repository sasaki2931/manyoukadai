class AddDeadlineToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :deadline, :date, :null => false, :default => '2020-01-01'
  end
end
