class AddStrategyRecordIdToOrderList < ActiveRecord::Migration
  def change
    add_column :order_lists, :strategy_record_id, :integer
  end
end
