class AddDetailsToBasketContingencies < ActiveRecord::Migration
  def change
    add_column :basket_contingencies, :complex_contingency_id, :integer
    add_column :basket_contingencies, :match_operator, :integer
  end
end
