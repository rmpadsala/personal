class AddBraintreeCustomerIdToAlgofastUsers < ActiveRecord::Migration
  def change
    add_column :algofast_users, :braintree_customer_id, :text
  end
end
