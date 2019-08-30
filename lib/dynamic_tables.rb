require 'dynamic_tables/version'

module DynamicTables
  mattr_accessor :column_quantity

  def self.setup
    yield self
  end
end
