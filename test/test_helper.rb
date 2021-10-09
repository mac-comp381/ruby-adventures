# Require everything directly under lib/

Dir[File.join(File.dirname(__FILE__), "../lib/*.rb")].each do |lib_file|
  require lib_file
end

require "minitest/autorun"
