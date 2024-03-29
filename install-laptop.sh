echo "***** Update standart applications *****"
sudo apt update
sudo apt -y upgrade
sudo apt install -y python3 python3-venv python3-pudb build-essential libssl-dev libffi-dev python3-dev exuberant-ctags vim-gui-common neovim git python3-ipython jupyter-core python3-pip python3-matplotlib python3-scipy mosh curl wget zip unzip thunderbird anki gimp telegram-desktop discord doublecmd-common smplayer zathura zathura-djvu zathura-pdf-poppler stow htop tmux mc keepassxc freeplane xcompmgr guake i3 j4-dmenu-desktop kde-spectacle pavucontrol pasystray numlockx compton nitrogen alacritty build-essential cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libpulse-dev libjsoncpp-dev i3-wm light code polybar docker.io docker-compose docker-registry docker-clean python3-docker pylint jupyter-nbconvert tree sway waybar wofi grim slurp swaylock swayidle mako-notifier gammastep fonts-hack

sudo chmod +s /usr/bin/light
xcompmgr -c -l0 -t0 -r0 -o.00

# Install siji font
cd
git clone https://github.com/stark/siji && cd siji
. install.sh

# install soft
cd
echo "***** Install Flatpak applications *****"
flatpak install -y flathub com.slack.Slack
flatpak install -y io.dbeaver.DBeaverCommunity
flatpak install -y flathub org.gnome.Fractal

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
stow xsession
stow dunst
stow alacritty
stow zathura
stow ipython
stow jupyter
cd laptop
stow i3
stow polybar
stow sway
stow waybar
stow gammastep
cd ..

# Google Chrome
echo "***** Google Chrome Install *****"
cd
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb

# Yandex Disk
echo "***** Yandex Disk Install *****"
cd
sudo wget http://repo.yandex.ru/yandex-disk/yandex-disk_latest_amd64.deb
sudo dpkg -i yandex-disk_latest_amd64.deb
echo "For setup Yandex disk run yandex-disk setup"


echo "***** Remove temporary files *****"
sudo apt -y clean
cd
rm -f yandex-disk_latest_amd64.deb
rm -f google-chrome-stable_current_amd64.deb
