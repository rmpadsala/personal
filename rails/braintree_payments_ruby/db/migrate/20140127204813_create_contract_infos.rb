class CreateContractInfos < ActiveRecord::Migration
  def change
    create_table :contract_infos do |t|
      t.string :contract
      t.integer :contract_type
      t.integer :order_info_id

      t.timestamps
    end
  end
end
