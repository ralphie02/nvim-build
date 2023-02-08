# neovim installation (ARM64 only)

```bash
wget -P /tmp https://github.com/ralphie02/neovim-build/releases/download/<version>/neovim.tar.gz
sudo mkdir -p /opt/bin
cd /opt
sudo tar xvf neovim.tar.gz
sudo ln -s /opt/neovim/bin/nvim /opt/bin/nvim
```
