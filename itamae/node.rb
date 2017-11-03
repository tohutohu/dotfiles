
node.reverse_merge!({
  "user" => "isucon"
})

package 'curl'

execute 'download nvm' do
  command 'curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash'
  user node['user']
end
