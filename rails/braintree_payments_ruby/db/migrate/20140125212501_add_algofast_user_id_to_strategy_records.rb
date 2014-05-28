class AddAlgofastUserIdToStrategyRecords < ActiveRecord::Migration
  def change
    add_column :strategy_records, :AlgofastUserId, :integer
  end
end
