cookbook_file '/tmp/cle' do
  source 'cle'
  mode 0600
end.run_action(:create)


node.set[:cle] = IO.read('/tmp/cle')

directory '/etc/nginx/ssl' do
  recursive true
end

execute 'pull numicerts' do
  command <<-END
    aws s3 cp s3://orange-server-configs/certs/numicerts.tar.enc /etc/nginx/ssl/numicerts.tar.enc
  END
end

execute 'decrypt' do
  cwd '/etc/nginx/ssl'
  command <<-END
    openssl enc -d -aes-256-cbc -k #{node[:cle]} -in numicerts.tar.enc -out numicerts.tar
  END
end

execute 'extract tar numicerts.tar' do
  cwd '/etc/nginx/ssl'
	command 'tar -xf ./numicerts.tar'
end

file '/etc/nginx/ssl/numicerts.tar' do
  action :delete
end

file '/etc/nginx/ssl/numicerts.tar.enc' do
  action :delete
end

file '/tmp/cle' do
  action :delete
end