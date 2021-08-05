require 'activerecord-normalizations/normalizations'

module ActiveRecord::Normalizations
  class Railtie < Rails::Railtie
    initializer "normalizations.initialize" do |app|
      ActiveSupport.on_load :active_record do
        include ActiveRecord::Normalizations
      end
    end
  end
end
