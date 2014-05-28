require "json"
require "strategy_records_model"
require "rest_client"
require "hashie"

class StrategiesController < ApplicationController		
	include ApplicationHelper

	before_action :request_indicator_list, only: [:new, :edit]

	PLATFORMS = [["Tradier", "1"]]
	STRATEGY_MATRIX_TYPE = [["SIMPLE","1"], ["COMPLEX","3"], ["BASKET","2"]]
	DURATION = [["WFA","1"], ["WUT","2"], ["WUF","3"]]
	ORDER_TYPES = [["MARKET","1"], ["LIMIT","1"]]
	ORDER_DURATIONS = [["DAY","1"], ["GTC","2"]]
	CONTRACT_TYPES = [["STOCK", "1"], ["FUTURE", "2"], ["OPTIONS", "3"]]
	LOGIC = [["Less than", "1"], ["Greater than", "2"],
			 ["Less than or equal", "3"], ["Greater than or equal", "4"],
			 ["Equal", "5"]]

	MATCH_OPERATOR = [["NONE", "0"], ["AND", "1"], ["OR", "2"]]
	
	def index
		#query all the strategies here.
		@strategy = Strategy.new(strategy_record: session[:strategy_record])
		record_id = @strategy.strategy_record.record_id
		flash[:success] = "Successfully created strategy #{record_id}."
		
	end

	def new
		@strategy_record = StrategyRecord.new
		@strategy = Strategy.new(strategy_record: @strategy_record)
	end

	def edit
	end

	def show
		@strategy = Strategy.new(strategy_record: session[:strategy_record])
		record_id = @strategy.strategy_record.record_id
		flash[:success] = "Successfully created strategy #{record_id}."

		# remove strategy record from session hash...
		session[:strategy_record] = nil		
	end

	def create
		@strategy = Strategy.new(params[:strategy])
		Rails.logger.debug("Create strategy: #{@strategy.to_json}")

		#if !@strategy.valid?
		#	render 'new'
		#end		


		uri = 
			SampleStrategyBuilder::Application.config.APPLICATION_CONSTANTS["algofast_service_uri"]		
		@createUri = uri + '/events';
		response = RestClient.post @createUri, params[:strategy].to_json, 
			{				
				:content_type => :json,
				:accept => :json,
				:authorization => SampleStrategyBuilder::Application.config.APPLICATION_CONSTANTS["strategy_create_authorization"]
			}		

		# Parse response
		data = JSON.parse(response)
		if !data.nil?
			if data['response']['success'] == true
				Rails.logger.debug("Request Successful")
				jsonStrategyResponse = data['response']['data']
				# we can use flash array as well to pass data between
				# different requests
				session[:strategy_record] = Hashie::Mash.new jsonStrategyResponse				
      			
      			redirect_to strategies_path

			else
				Rails.logger.debug("Request failed, reason: #{data['response']['message']}")
			end
		else
			Rails.logger.debug("Invalid response received from algofast service")
		end
	end

	private
		def user_params
      		#params.require(:strategy).permit(:algofast_user_id)
    	end

    	# Method to request all the tradable indicators
		def request_indicator_list		
			@uri = 
				SampleStrategyBuilder::Application.config.APPLICATION_CONSTANTS["algofast_service_uri"]
			# Send request to algofast service to download all NASDAQ indicators
			@indicatorUri = @uri + '/events/nasdaq';

			response = RestClient.get @indicatorUri, 
			{
				:content_type => :json,
				:accept => :json,
				:authorization => SampleStrategyBuilder::Application.config.APPLICATION_CONSTANTS["nasdaq_req_authorization"]			
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
