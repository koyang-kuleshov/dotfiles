echo "***** Update standart applications *****"
sudo apt update
sudo apt -y upgrade
sudo apt install -y python3 python3-venv python3-pudb build-essential libssl-dev libffi-dev python3-dev exuberant-ctags pyflakes vim-gui-common neovim
sudo apt install -y thunderbird anki gimp telegram-desktop discord doublecmd-common smplayer zathura zathura-djvu zathura-pdf-poppler stow htop tmux tilix mc keepassxc i3 j4-dmenu-desktop kde-spectacle pavucontrol pasystray numlockx

# install soft
cd ~
mkdir soft
cd soft
git clone https://github.com/Hskl14/polybar-weather.git
# echo "***** Install Flatpak applications *****"
# sudo flatpak install flathub com.slack.Slack
# sudo flatpak install io.dbeaver.DBeaverCommunity
# sudo flatpak install flathub org.gnome.Fractal

# Stow
echo "***** Stow settings *****"
rm ../.bashrc ../.profile
stow bash
stow flake8
stow git
stow latexmk
stow nvim
stow pudb
stow tmux
stow i3
stow xsession
stow spectacle

# Google Chrome
echo "***** Google Chrome Install *****"
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb

# Yandex Disk
echo "***** Yandex Disk Install *****"
sudo wget http://repo.yandex.ru/yandex-disk/yandex-disk_latest_amd64.deb
sudo dpkg -i yandex-disk_latest_amd64.deb
echo "For setup Yandex disk run yandex-disk setup"

echo "***** Remove temporary files *****"
sudo apt -y autoremove
rm -f YANDEX-DISK-KEY.GPG 
rm -f yandex-disk_latest_amd64.deb
rm -f google-chrome-stable_current_amd64.deb
