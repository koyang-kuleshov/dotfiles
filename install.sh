sudo apt update
sudo apt -y upgrade
sudo apt install -y python3 python3-venv python3-pudb build-essential libssl-dev libffi-dev python3-dev exuberant-ctags pyflakes vim-gui-common nvim
sudo apt install -y thunderbird anki gimp slack telegram-desktop discord double-cmd-common smplayer zathura zathura-djvu zathura-pdf-poppler stow htop tmux tilix mc keepassxc

# Google Chrome
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb

sudo flatpak install Slack DBeaver Fractal

# Stow
cd ~/dotfiles
stow bash flake8 git latexmk nvim pudb tmux

# Yandex Disk
cd ..
sudo wget -O YANDEX-DISK-KEY.GP  http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG
sudo apt-key add YANDEX-DISK-KEY.GPG
sudo echo "deb http://repo.yandex.ru/yandex-disk/deb/ stable main" >>/etc/apt/sources.list.d/yandex-disk.list
sudo apt update
sudo apt install yandex-disk
