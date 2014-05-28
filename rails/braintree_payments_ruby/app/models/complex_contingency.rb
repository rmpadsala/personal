class ComplexContingency < ActiveRecord::Base
	belongs_to :strategy_record
	has_many :basket_contingencies, dependent: :destroy

	accepts_nested_attributes_for :basket_contingencies, :allow_destroy => true
end
