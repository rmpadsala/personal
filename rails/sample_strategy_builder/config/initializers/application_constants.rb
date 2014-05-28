SampleStrategyBuilder::Application.config.APPLICATION_CONSTANTS = 
	YAML.load_file("#{Rails.root}/config/application_constants.yml")[Rails.env]