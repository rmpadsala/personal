class StrategyRecordsController < ApplicationController
	before_filter :authenticate_algofast_user!
	before_action :request_indicator_list, only: [:new]

	LOGIC = [["Less than", "1"], ["Greater than", "2"],
			 ["Less than or equal", "3"], ["Greater than or equal", "4"],
			 ["Equal", "5"]]

	CONTRACT_TYPES = [["STOCK", "1"], ["FUTURE", "2"], ["OPTIONS", "3"]]

	ORDER_TYPES = [["MARKET","1"], ["LIMIT","1"]]

	ORDER_DURATIONS = [["DAY","1"], ["GTC","2"]]

	DURATION = [["WFA","1"], ["WUT","2"], ["WUF","3"]]
	
	def index
		
	end

	def new
		@strategy_record = StrategyRecord.new
		@strategy_record.build_complex_contingency
		2.times do 
			basket_contingency = @strategy_record.complex_contingency.basket_contingencies.build 
			2.times { basket_contingency.contingency_infos.build }				
		end

		@strategy_record.build_order_list
		1.times do
			order_info = @strategy_record.order_list.order_infos.build 
			order_info.build_contract_info
		end
	end

	def create
		@strategy_record = StrategyRecord.new(strategy_params)
		Rails.logger.debug("StrategyRecord JSON: #{@strategy_record.to_json}")

		render :action => 'index'
	end

	private
		def strategy_params
      		params.require(:strategy_record).permit(
      			:algofast_user_id, :duration, :exec_platform, :strategy_matrix_type,
      			:submit_time, :record_id, :state, 
      			:order_list_attributes => [ 
      				:order_info_atttributes => [
      					:order_tif, :price, :order_type, :qty, 
      					:routing_account, :side, :stop_px, 
      					:contract_info_attributes => [ 
      						:contract, :contract_type
      					]
  					]
  				]
  			)

    	end

    	# Method to request all the tradable indicators
		def request_indicator_list
			@uri = ENV["algofast_service_uri"]
			# Send request to algofast service to download all NASDAQ indicators
			@indicatorUri = @uri + '/events/nasdaq';

			response = RestClient.get @indicatorUri, 
			{
				:content_type => :json,
				:accept => :json,
				:authorization => ENV["nasdaq_req_authorization"]			
			}

			# Parse response
			data = JSON.parse(response)			
			if !data.nil?
				if data['response']['success'] == true
					Rails.logger.debug("Request Successful")
					jsonRecords = data['response']['data']['records']	
					@indicators = jsonRecords.map { 
						|indicator| AfIndicator.new(indicator) 
					}					
				else
					Rails.logger.debug("Request failed, reason: #{data['response']['message']}")
				end
			else
				Rails.logger.debug("Invalid response received from algofast service")
			end			
		end
end
