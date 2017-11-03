require 'open-uri'
node.reverse_merge!({
  "user" => "isucon",
  "neovimBuild" => false
})

directory "/home/#{node['user']}/.ssh" do
  owner node['user']
  group node['user']
  mode '700'
end

file "/home/#{node['user']}/.ssh/authorized_keys" do
  action :create
  owner node['user']
  group node['user']
  mode "600"
end

file "/home/#{node['user']}/.ssh/authorized_keys" do
  action :edit
  block do |content|
    [
      'tohutohu',
      'kaz'
    ].each do |id|
      key = open("https://github.com/#{id}.keys").read
      if !content.include?(key)
        content.concat(key)
      end
    end
  end
end

package 'wget'
package 'unzip'
package 'dstat'

execute 'kataribe download' do
  command 'wget -q https://github.com/matsuu/kataribe/releases/download/v0.3.0/linux_amd64.zip -O kataribe.zip'
  cwd "/home/#{node['user']}/"
  user node['user']
end

execute 'kataribe unzip' do
  command 'unzip -o kataribe.zip'
  cwd "/home/#{node['user']}/"
  user node['user']
end

file "/home/#{node['user']}/.bashrc" do
  action :create
  owner node['user']
  group node['user']
  mode "777"
end

file "/home/#{node['user']}/.bashrc" do
  action :edit
  block do |content|
    if !content.include?("alias kataru='sudo cat /var/log/nginx/access.log | /home/#{node['user']}/kataribe -f /home/isucon/kataribe.toml' \n")
      content.concat("alias kataru='sudo cat /var/log/nginx/access.log | /home/#{node['user']}/kataribe -f /home/isucon/kataribe.toml' \n") 
    end
  end
end

file "/etc/nginx/nginx.conf" do
  action :edit
  block do |content|
    if !content.include?(
<<"eos"
  #log_format with_time '$remote_addr - $remote_user [$time_local] '
  #'"$request" $status $body_bytes_sent '
  #'"$http_referer" "$http_user_agent" $request_time';
eos
    )
      content.concat(
<<"eos"



  #log_format with_time '$remote_addr - $remote_user [$time_local] '
  #'"$request" $status $body_bytes_sent '
  #'"$http_referer" "$http_user_agent" $request_time';
eos
      )
    end
  end
end

package 'perl'

execute 'percona download' do
  command "wget -q percona.com/get/percona-toolkit.tar.gz -O percona.tar.gz"
  cwd "/home/#{node['user']}"
  user node['user']
end

directory "/home/#{node['user']}/percona"

execute 'percona unzip' do
  command 'tar kxf percona.tar.gz -C percona --strip-components 1'
  cwd "/home/#{node['user']}"
  user node['user']
end

execute 'percona install' do
  command 'perl Makefile.PL && make install'
  cwd "/home/#{node['user']}/percona"
  user node['user']
end

execute 'myprofiler download' do
  command "wget -q https://github.com/KLab/myprofiler/releases/download/0.2/myprofiler.linux_amd64.tar.gz -O myprofiler.tar.gz"
  cwd "/home/#{node['user']}"
  user node['user']
end

execute 'myprofiler unzip' do
  command 'tar kxf myprofiler.tar.gz'
  cwd "/home/#{node['user']}"
  user node['user']
end
