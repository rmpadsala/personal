class RemoveMaskedCcNumberFromSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :masked_cc_number, :string
  end
end
