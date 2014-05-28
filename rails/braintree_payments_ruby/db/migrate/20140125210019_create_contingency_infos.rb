class CreateContingencyInfos < ActiveRecord::Migration
  def change
    create_table :contingency_infos do |t|

      t.timestamps
    end
  end
end
