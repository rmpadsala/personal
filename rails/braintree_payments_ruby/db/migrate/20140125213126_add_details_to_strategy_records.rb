class AddDetailsToStrategyRecords < ActiveRecord::Migration
  def change
    add_column :strategy_records, :duration, :integer
    add_column :strategy_records, :exec_platform, :integer
    add_column :strategy_records, :strategy_matrix_type, :integer
    add_column :strategy_records, :submit_time, :string
    add_column :strategy_records, :record_id, :string
    add_column :strategy_records, :state, :integer
  end
end
