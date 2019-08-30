require 'rails/generators'
module DynamicTables
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def create_initializer
        template 'dynamic_tables.rb', 'config/initializers/dynamic_tables.rb'
      end

    end
  end
end
