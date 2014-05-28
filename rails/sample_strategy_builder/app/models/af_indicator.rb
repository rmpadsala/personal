class AfIndicator
	attr_accessor :release_id, :component_id, :description, :data_type,
		:has_cusip, :indicator_id, :indicator_category, :indicator_name, 
		:indicator_type, :indicator_source

	def to_s
		"#{@indicator_category}, #{@indicator_id}, #{@indicator_name}, 
		 #{@indicator_source}, #{@release_id}, #{@component_id}, 
		 #{@description}, #{@has_cusip}"
	end

	def initialize(attributes={})
		@indicator_id = attributes['indicator_id']
		@indicator_category = attributes['indicator_category']
		@indicator_name = attributes['indicator_name']
		@indicator_type = attributes['indicator_type']
		@indicator_source = attributes['indicator_source']
		@release_id = attributes['release_id']
		@component_id = attributes['component_id']
		@description = attributes['description']
		@data_type = attributes['data_type']
		@has_cusip = attributes['has_cusip']
	end
end