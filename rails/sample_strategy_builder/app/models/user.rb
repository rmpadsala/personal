class User < ActiveRecord::Base
	def self.columns() @columns ||= []; end

	def self.column(name, sql_type = nil, default = nil, null = true)
		columns << ActiveRecord::ConnectionAdapters::Column.new(
			name.to_s, default, sql_type.to_s, null)
	end

	column :first_name, :string
	column :last_name, :string

	validates :first_name, presence: true
	validates :last_name, presence: true
end
