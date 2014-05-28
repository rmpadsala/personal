class CreateComplexContingencies < ActiveRecord::Migration
  def change
    create_table :complex_contingencies do |t|

      t.timestamps
    end
  end
end
