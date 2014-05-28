class OrderInfo < ActiveRecord::Base
	belongs_to :order_list

	has_one :contract_info, dependent: :destroy
end
