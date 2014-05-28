class AddDetailsToOrderInfo < ActiveRecord::Migration
  def change
    add_column :order_infos, :order_tif, :integer
    add_column :order_infos, :order_type, :integer
    add_column :order_infos, :price, :double
    add_column :order_infos, :qty, :integer
    add_column :order_infos, :routing_account, :string
    add_column :order_infos, :side, :integer
    add_column :order_infos, :stop_px, :double
    add_column :order_infos, :strategy_record_id, :integer
  end
end
