cookbook_file '/tmp/cle' do
  source 'cle'
  mode 0600
end.run_action(:create)


node.set[:cle] = IO.read('/tmp/cle')

directory '/etc/pki/tls/certs' do
  recursive true
end

execute 'pull ca-certs' do
  command <<-END
    aws s3 cp s3://orange-server-configs/certs/ca-certs.tar.enc /etc/pki/tls/certs/ca-certs.tar.enc
  END
end

execute 'decrypt' do
  cwd '/etc/pki/tls/certs'
  command <<-END
    openssl enc -d -aes-256-cbc -k #{node[:cle]} -in ca-certs.tar.enc -out ca-certs.tar
   END
end

execute 'extract cacerts.tar and append to ca-bundle' do
  cwd '/etc/pki/tls/certs'
	command 'tar -xf ./ca-certs.tar;cat vsignA.pem vsignB.pem >> ca-bundle.crt;/usr/bin/c_rehash .'
end

execute 'update ca bundle' do
  cwd '/etc/pki/tls'
  command <<-END
    curl http://curl.haxx.se/ca/cacert.pem > /etc/pki/tls/cert.pem
   END
end

file '/etc/pki/tls/certs/ca-certs.tar' do
  action :delete
end

file '/etc/pki/tls/certs/ca-certs.tar.enc' do
  action :delete
end

file '/tmp/cle' do
  action :delete
end
