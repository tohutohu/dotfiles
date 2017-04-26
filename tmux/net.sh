timeout 2 ping -w 1 -c 1 google.co.jp > /dev/null 2>&1
if [ $? != 0 ];then
  echo "#[bg=red,fg=yellow]Network Disconnected!!! #[default]"
  exit 1
fi



if [ "$(find ~/dotfiles/tmp/net-speed -mmin -$((5)) | wc -l)" -eq 0 ];then
  speedtest --server 7510 --simple --timeout 10 | awk '{gsub("Ping","P", $0);gsub("Download", "Down", $0);gsub("Upload", "Up", $0);gsub(" ", "", $0);gsub("bit/s", "bps", $0);ORS=" ";print}' > ~/dotfiles/tmp/net-speed
  cat ~/dotfiles/tmp/net-speed
else
  cat ~/dotfiles/tmp/net-speed
fi
