require 'activerecord-normalizations/normalizations'

module ActiveRecord::Normalizations
  class Railtie < Rails::Railtie
    config.after_initialize do |app|
      ActiveSupport.on_load :active_record do
        include ActiveRecord::Normalizations
      end
    end
  end
end
