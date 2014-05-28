class CreateBasketContingencies < ActiveRecord::Migration
  def change
    create_table :basket_contingencies do |t|

      t.timestamps
    end
  end
end
