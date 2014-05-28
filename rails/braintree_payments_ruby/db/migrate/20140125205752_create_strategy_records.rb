class CreateStrategyRecords < ActiveRecord::Migration
  def change
    create_table :strategy_records do |t|

      t.timestamps
    end
  end
end
