yum_repository "cassandra" do
	description 'Apache Cassandra'
	baseurl 'https://www.apache.org/dist/cassandra/redhat/311x/'
	gpgcheck true
	gpgkey 'https://www.apache.org/dist/cassandra/KEYS'
end

package 'cassandra' do
  notifies :restart, 'execute[reload_systemd]', :delayed
end

execute 'reload_systemd' do
  action :nothing
  command 'systemctl daemon-reload'
end

service 'cassandra' do
  action :start
end
