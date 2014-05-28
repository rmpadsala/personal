class AddOrderListIdToOrderInfo < ActiveRecord::Migration
  def change
    add_column :order_infos, :order_list_id, :integer
  end
end
