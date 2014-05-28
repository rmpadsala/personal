class BasketContingency < ActiveRecord::Base
	belongs_to :complex_contingency
	has_many :contingency_infos, dependent: :destroy

	accepts_nested_attributes_for :contingency_infos, :allow_destroy => true
end