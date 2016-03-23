Given /^clockwork\.god config file exists$/ do
  File.exists?("/etc/god/conf.d/clockwork.god").should be_true
end

Given /^God is running$/ do
  `ps aux | grep god`.should include("god")
end

Then /^clockwork should be running$/ do
  `ps aux | grep clockwork`.should include("app/clock.rb")
end

Then /^clockwork should be running using the pid from clockwork\.pid$/ do
  pid = `cat /srv/www/tangerine/current/tmp/pids/clockwork.pid`
  `ps aux | grep clockwork`.should include(pid)
end
