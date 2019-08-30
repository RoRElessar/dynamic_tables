require 'rails/generators/base'
require 'rails/generators/active_record'
require 'active_support/concern'
require 'rails/generators/actions/create_migration'

module DynamicTables
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../../templates', __FILE__)

      def create_initializer
        template 'dynamic_tables.rb', 'config/initializers/dynamic_tables.rb'
      end

      def generate_models
        Rails::Generators.invoke 'active_record:model', %w[dynamic_table column_quantity:integer], migration: true
        Rails::Generators.invoke 'active_record:model', %w[table_head column_name:string dynamic_table:references], migration: true
        Rails::Generators.invoke 'active_record:model', %w[table_row sort_position:integer row_value:string data_label:string dynamic_table:references], migration: true
      end

      def inject_dynamic_table_content
        dynamic_table_content = dynamic_table_model_content
        table_head_content = table_head_model_content
        table_row_content = table_row_model_content

        inject_into_class(File.join('app', 'models', 'dynamic_table.rb'), 'DynamicTable', dynamic_table_content)
        inject_into_class(File.join('app', 'models', 'table_head.rb'), 'TableHead', table_head_content)
        inject_into_class(File.join('app', 'models', 'table_row.rb'), 'TableRow', table_row_content)
      end

      private
#
      def dynamic_table_model_content
        buffer = <<-CONTENT
  has_one :table_head, dependent: :destroy
  has_many :table_rows, dependent: :destroy
  accepts_nested_attributes_for :table_head
  accepts_nested_attributes_for :table_rows, allow_destroy: true

  validates :column_quantity, presence: true, inclusion: column_quantity
        CONTENT
        buffer
      end

      def table_head_model_content
        buffer = <<-CONTENT
  belongs_to :dynamic_table
        CONTENT
        buffer
      end

      def table_row_model_content
        buffer = <<-CONTENT
  belongs_to :dynamic_table

  default_scope { order(sort_position: :asc) }
        CONTENT
        buffer
      end
    end
  end
end
