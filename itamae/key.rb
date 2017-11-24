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
