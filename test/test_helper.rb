require 'bundler/setup'
require "minitest/autorun"

Bundler.require(:default, :test)

require (Pathname.new(__FILE__).dirname + '../lib/startblock').expand_path

Dir["./test/support/**/*.rb"].each { |file| require file }

include StartblockTestHelpers

create_tmp_directory
drop_dummy_database
remove_project_directory
run_startblock
