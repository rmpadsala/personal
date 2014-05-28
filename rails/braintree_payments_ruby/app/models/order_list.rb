class OrderList < ActiveRecord::Base
	belongs_to :strategy_record

	has_many :order_infos, dependent: :destroy
end
