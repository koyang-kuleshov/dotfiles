echo "***** Update standart applications *****"
sudo apt update
sudo apt -y upgrade
sudo apt install -y python3 python3-venv python3-pudb build-essential libssl-dev libffi-dev python3-dev exuberant-ctags vim-gui-common git python3-ipython jupyter-core python3-pip python3-matplotlib python3-scipy mosh curl wget zip unzip thunderbird anki gimp doublecmd-common smplayer zathura zathura-djvu zathura-pdf-poppler stow htop tmux mc keepassxc freeplane xcompmgr guake i3 j4-dmenu-desktop kde-spectacle pavucontrol pasystray numlockx compton nitrogen alacritty cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libpulse-dev libjsoncpp-dev i3-wm light code polybar docker.io docker-compose docker-registry docker-clean python3-docker pylint jupyter-nbconvert tree sway waybar wofi grim slurp swaylock swayidle gammastep fonts-hack ripgrep fd-find meson ninja-build scdoc wayland-protocols libdbus-glib-1-dev libgirepository1.0-dev libwayland-dev npm wl-clipboard

sudo npm i -g pyright

sudo chmod +s /usr/bin/light
xcompmgr -c -l0 -t0 -r0 -o.00
/home/michelkoyangkuleshov/homework/examles/2_dwh/3-meet-pentaho/csv/books.csv

# install soft
cd
echo "***** Install Flatpak applications *****"
flatpak install -y flathub com.slack.Slack
flatpak install -y flathub org.gnome.Fractal
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub org.telegram.desktop
flatpak install -y flathub com.getpostman.Postman

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
stow i3
stow polybar
stow sway
stow waybar
stow gammastep
stow sql-language-server
stow ideavim
stow xresources
cd ..

pip3 install neovim

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
