require 'dynamic_tables/version'
require 'rails'
require 'active_support/dependencies'

module DynamicTables
  mattr_accessor :column_quantity

  def self.setup
    yield self
  end
end
