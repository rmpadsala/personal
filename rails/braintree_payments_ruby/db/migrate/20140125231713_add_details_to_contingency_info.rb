class AddDetailsToContingencyInfo < ActiveRecord::Migration
  def change
    add_column :contingency_infos, :expected_value, :string
    add_column :contingency_infos, :indicator_id, :string
    add_column :contingency_infos, :is_matched, :boolean
    add_column :contingency_infos, :is_released, :boolean
    add_column :contingency_infos, :logic, :integer
    add_column :contingency_infos, :source, :integer
    add_column :contingency_infos, :strategy_type, :integer
  end
end
