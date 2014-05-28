class RemoveStrategyRecordIdFromOrderInfo < ActiveRecord::Migration
  def change
    remove_column :order_infos, :strategy_record_id, :integer
  end
end
