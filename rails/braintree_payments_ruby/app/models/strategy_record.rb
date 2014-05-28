class StrategyRecord < ActiveRecord::Base
	belongs_to :algofast_user
	has_one :complex_contingency, dependent: :destroy
	has_one :order_list, dependent: :destroy

	accepts_nested_attributes_for :complex_contingency, :allow_destroy => true
	accepts_nested_attributes_for :order_list, :allow_destroy => true

	attr_accessor :algofast_user_id
end
