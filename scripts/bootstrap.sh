# TMUX config setup
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -f ~/.tmux.conf
ln -sr ./tmux/.tmux.conf ~/
