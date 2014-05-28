class AddBraintreeCustomerIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :braintree_customer_id, :string
  end
end
