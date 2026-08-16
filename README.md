Personal Neovim config

Note that the fork from kickstart-modular.nvim is no longer relevant since kickstart.nvim was abandoned in 2025.

1. Install neovim (ansible-homelab installs neovim snap with --classic mode)

2. Install C compiler tooling (included in [maubuz/ansible-homelab](https://github.com/maubuz/ansible-homelab))

```sh
sudo apt install build-essential
```

3. Download personal config repo:

```sh
git clone https://github.com/maubuz/mauvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

4. Run nvim and let it install dependencies
