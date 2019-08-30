# frozen_string_literal: true

module Devise
  module Generators
    module Helpers
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
