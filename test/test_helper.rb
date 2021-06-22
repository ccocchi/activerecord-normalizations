require "activerecord-normalizations"
require 'activerecord-normalizations/normalizations'

require "minitest/autorun"

require "active_support"
require "active_record"
require "nulldb/core"

ActiveRecord::Base.establish_connection(
  adapter: :nulldb,
  schema: File.expand_path('../schema.rb', __FILE__)
)
