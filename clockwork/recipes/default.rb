node[:deploy].each do |application, deploy|

  template "/etc/god/conf.d/clockwork.god" do
    source "clockwork.god.erb"
    owner "root"
    group "root"
    mode 0755
    variables( :deploy => deploy )
    notifies :restart, resources(:service => "god")
  end

  execute "Restart Clockwork" do
    command <<-EOF
    god stop clockwork
    god start clockwork
    EOF
  end
end
