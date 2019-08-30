require 'rails/generators/active_record'
require 'generators/dynamic_tables/helpers'

module ActiveRecord
  module Generators
    class DynamicTablesGenerator < ActiveRecord::Generators::Base

      def generate_models
        invoke 'active_record:model', 'DynamicTable', migration: true
        invoke 'active_record:model', 'TableHead', migration: true
        invoke 'active_record:model', 'TableRow', migration: true
      end

      def inject_dynamic_table_content
        dynamic_table_content = dynamic_table_model_content
        table_head_content = table_head_model_content
        table_row_content = table_row_model_content

        inject_into_class(File.join('app', 'models', 'DynamicTable.rb'), DynamicTable, dynamic_table_content)
        inject_into_class(File.join('app', 'models', 'TableHead.rb'), TableHead, table_head_content)
        inject_into_class(File.join('app', 'models', 'TableRow.rb'), TableRow, table_row_content)
      end

      def table_migration_data
        <<RUBY
        t.integer :column_quantity
RUBY
      end

      def table_head_migration_data
        <<RUBY
        t.string :column_name
        t.references :dynamic_table, foreign_key: true
RUBY
      end

      def table_row_migration_data
        <<RUBY
        t.integer :sort_position
        t.string :row_value
        t.string :data_label
        t.references :dynamic_table
RUBY
      end

      def rails5_and_up?
        Rails::VERSION::MAJOR >= 5
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" if rails5_and_up?
      end

    end
  end
end
