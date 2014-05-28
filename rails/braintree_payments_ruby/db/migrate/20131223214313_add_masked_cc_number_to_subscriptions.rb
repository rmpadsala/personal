class AddMaskedCcNumberToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :masked_cc_number, :string
  end
end
