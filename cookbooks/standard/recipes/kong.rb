yum_repository "kong" do
	description 'bintray-mashape-kong-rpm-el7-0.10.x'
	baseurl 'https://dl.bintray.com/mashape/kong-rpm-el7-0.10.x'
	gpgcheck false
end

package 'kong'

template '/etc/kong/kong.conf' do
  source 'kong.conf.erb'
  mode 644
  notifies :restart, 'service[kong]', :delayed
end

#https://github.com/Mashape/kong/issues/2471#issuecomment-298213185
template '/usr/lib/systemd/system/kong.service' do
  source 'kong.service.erb'
  mode 644
  notifies :restart, 'execute[reload_systemd]', :delayed
end

execute 'reload_systemd' do
  action :nothing
  command 'systemctl daemon-reload'
end

service 'kong' do
  action :nothing
end
