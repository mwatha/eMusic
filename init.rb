at_exit do
  require "irb"
  require "drb/acl"
  require "sqlite"
end

load "passenger start"
