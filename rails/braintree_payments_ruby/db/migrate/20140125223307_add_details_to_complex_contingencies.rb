class AddDetailsToComplexContingencies < ActiveRecord::Migration
  def change
    add_column :complex_contingencies, :strategy_record_id, :integer
    add_column :complex_contingencies, :match_operator, :integer
  end
end
