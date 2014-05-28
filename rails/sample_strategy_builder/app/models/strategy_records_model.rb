class Strategy
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  include ActiveModel::Validations  

  attr_accessor :strategy_record

  #validates :strategy_record, presence: true

  def initialize(options={})
    @strategy_record=options[:strategy_record]
  end

  def persisted?
    false
  end
end

class StrategyRecord
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  include ActiveModel::Validations  

  attr_accessor :algofast_user_id,:duration,:exec_platform,
    :strategy_matrix_type,:submit_time,:order_list,
    :basket_contingencies,:simple_contingency,:record_id,
    :state, :complex_contingencies

  #validates :algofast_user_id, presence: true

  def initialize(options={})
      @algofast_user_id = options[:algofast_user_id]
      @duration = options[:duration]
      @exec_platform = 1 if options[:exec_platform].nil? 
      @strategy_matrix_type = options[:strategy_matrix_type]
      @submit_time = ""
      @record_id = 0 if options[:record_id].nil?
      @state = 1 if options[:state].nil?
      @order_list = [OrderInfo.new] if options[:order_list].nil?
      @simple_contingency = SimpleContingency.new if options[:simple_contingency].nil?
      @basket_contingencies = BasketContingencies.new if options[:basket_contingencies].nil?
      @complex_contingencies = ComplexContingencies.new if options[:complex_contingencies].nil?
  end  
end

class BasketContingencies
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion

  attr_accessor :match_operator, :contingency_info
  
  def initialize(options={})
    @contingency_info = [ContingencyInfo.new] if options[:contingency_info].nil?
    @match_operator = 0 if options[:match_operator].nil?
  end

  def persisted?
    false
  end

end

class ComplexContingencies
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion

  attr_accessor :match_operator, :contingency_info

  def initialize(options={})
    @contingency_info = [BasketContingencies.new] if options[:contingency_info].nil?
    @match_operator = 0 if options[:match_operator].nil?
  end

  def persisted?
    false
  end

end


class SimpleContingency  
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion

  attr_reader :contingency_info

  #validates :contingency_info presence: true

  def initialize(options={})
    @contingency_info = ContingencyInfo.new if options[:contingency_info].nil?
  end
end  

class OrderInfo  
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion

  attr_accessor :contract_info,:order_tif,:order_type,
    :price,:qty,:routing_account,:side,:stop_px

  #validates :order_tif, :order_type, :price, :qty,
  #          :routing_account, :side, :stop_px presence: true
  
  def initialize(options={})
      @contract_info = ContractInfo.new if options[:contract_info].nil?
      @order_tif = options[:order_tif]
      @order_type = options[:order_type]
      @price = options[:price]
      @qty = options[:qty]
      @routing_account = options[:routing_account]
      @side= options[:side]
      @stop_px = options[:stop_px]
  end  

  def persisted?
    false
  end
  
end

class ContractInfo 
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion

  attr_reader :contract, :contract_type  

  #validates :contract, :contract_type presence: true

  def initialize(options={})
    @contract = options[:symbol]
    @contract_type = options[:contract_type]
  end  

  def persisted?
    false
  end
  
end

class ContingencyInfo
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion

  attr_reader :expected_value, :indicator_id, :is_matched, :is_released,
    :logic, :source, :strategy_type

  #validates :expected_value, :indicator_id, :logic presence: true

  def initialize(options={})      
    @expected_value = options[:expected_value]
    @indicator_id = options[:indicator_id]
    @is_matched = false if options[:is_matched].nil?
    @is_released = false if options[:is_released].nil?
    @logic = options[:logic]
    @source = options[:source]
    @strategy_type = options[:strategy_type]
  end

  def persisted?
    false
  end
end 
