node[:deploy].each do |application, deploy|
  template "/etc/god/conf.d/sidekiq.god" do
    source "sidekiq.god.erb"
    owner "root"
    group "root"
    mode 0755
    variables( :deploy => deploy )
    notifies :restart, resources(:service => "god")
  end

  execute "Restart SideKiq" do
    command <<-EOF
    /etc/init.d/god restart
    /bin/sleep 10
    /usr/local/bin/god stop workers
    /bin/sleep 10
    /usr/local/bin/god start workers
    EOF
  end
end
