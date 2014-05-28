class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :description
      t.string :payment_token
      t.integer :algofast_user_id

      t.timestamps
    end
  end
end
