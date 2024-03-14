# neovim installation (ARM64 only)

```bash
wget -P /tmp https://github.com/ralphie02/nvim-build/releases/latest/download/neovim.tar.gz \
  && sudo mkdir -p /opt/bin \
  && cd /opt \
  && sudo tar xvf /tmp/neovim.tar.gz \
  && sudo ln -s /opt/nvim/bin/nvim /opt/bin/nvim
```
