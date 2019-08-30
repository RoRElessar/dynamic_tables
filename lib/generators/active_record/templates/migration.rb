# frozen_string_literal: true

class CreateDynamicTables < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :dynamic_tables do |t|
      <%= table_migration_data -%>
      t.timestamps
    end

    create_table :table_heads do |t|
      <%= table_head_migration_data -%>
      t.timestamps
    end

    create_table :table_rows do |t|
      <%= table_row_migration_data -%>
     t.timestamps
    end

  end
end
