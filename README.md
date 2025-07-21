# Tmux + nvim + fish

```
apt install tmux fish stow
wget https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
mv nvim-linux-x86_64 /opt/nvim
ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
rm /root/.config /root/.tmux.conf
cd /root/server_config/
stow .
```
