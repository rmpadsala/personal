class CreateOrderLists < ActiveRecord::Migration
  def change
    create_table :order_lists do |t|

      t.timestamps
    end
  end
end
