class AddBasketContingencyIdToContingencyInfo < ActiveRecord::Migration
  def change
    add_column :contingency_infos, :basket_contingency_id, :integer
  end
end
