
node.reverse_merge!({
  "user" => "isucon",
  "neovimBuild" => false
})



package 'libtool'
package 'libtool-bin'
package 'autoconf'
package 'cmake'
package 'g++'
package 'pkg-config'
package 'unzip'
package 'python-dev'
package 'python-pip'
package 'python3-dev'
package 'python3-pip'
package 'git'

execute 'sudo pip3 install neovim'

execute 'sudo git clone https://github.com/neovim/neovim.git' do
  cwd '/usr/src'
  not_if 'test -e /usr/src/neovim'
end

[
  'git fetch',
  'git checkout master',
  'git reset --hard HEAD',
  'sudo make',
  'sudo make install'
].each do |command|
  execute command do
    cwd '/usr/src/neovim'
  end
end

directory "/home/#{node['user']}/.config/nvim/"

remote_file "/home/#{node['user']}/.config/nvim/init.vim" do
  source '../config/.vimrc'
  mode '777'
  owner node['user']
  group node['user']
end

remote_file "/home/#{node['user']}/.config/nvim/dein.toml" do
  source '../config/dein.toml'
  mode '777'
  owner node['user']
  group node['user']
end

remote_file "/home/#{node['user']}/.config/nvim/dein_lazy.toml" do
  source '../config/dein_lazy.toml'
  mode '777'
  owner node['user']
  group node['user']
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
    if !content.include?(
<<-eof
alias vim="nvim"
alias svim="sudo -E nvim"
alias vi="nvim"
eof
)
      content.concat(
<<-eof
alias vim="nvim"
alias svim="sudo -E nvim"
alias vi="nvim"
eof
      ) 
    end
  end
end

