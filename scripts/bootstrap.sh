# TMUX config setup
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -f ~/.tmux.conf
ln -sr ./tmux/.tmux.conf ~/

# Kitty config setup
cd ~/.config
mkdir -p kitty
cd -
ls
rm -f ~/.config/kitty/kitty.conf
pwd
ln -sr ./kitty/kitty.conf ~/.config/kitty/
