#!/bin/bash

# Please set up the network proxy first

# set some path
PROJPATH=`pwd`
USERPATH=/home/maoyp

# get shell config file path


# main set
if uname -a | grep "Ubuntu" > /dev/null
then

# update sys
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y 

# install lazygit
if cat "$USERPATH/.bashrc" | grep "alias lg='lazygit'" > /dev/null
then
    :
else
    sudo add-apt-repository ppa:lazygit-team/release
    sudo apt-get update -y
    sudo apt-get install lazygit -y
    echo "alias lg='lazygit'" >> ~/.bashrc
fi

# set /etc/hosts
#if cat "/etc/hosts" | grep "raw.githubusercontent.com" > /dev/null
#then
#	:
#else
#	echo "199.232.28.133 raw.githubusercontent.com" >> /etc/hosts
#fi

# install neovim
if cat "$USERPATH/.bashrc" | grep "alias vim='nvim'" > /dev/null
then
    :
else
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
git clone https://github.com/neovim/neovim 
cd neovim && make
sudo make install
echo "alias vim='nvim'" >> ~/.bashrc
source ~/.bashrc
cd ../
rm -rf neovim
cp -r $PROJPATH/nvim ~/.config
fi

sudo apt-get install git -y

# install plug.vim
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# FZF
if [ ! -d "$USERPATH/.fzf" ]; then
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$USERPATH/.fzf/install 
source ~/.bashrc
fi

sudo apt-get install minicom -y
sudo apt-get install curl -y
sudo apt-get install file -y
sudo apt-get install wget -y
sudo apt-get install net-tools -y
sudo apt-get install python3 python3-pip -y

# NVM
if cat "$USERPATH/.bashrc" | grep "# NVM config" > /dev/null
then
	echo "NVM was installed"
	echo "NVM_DIR=$NVM_DIR"
else
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	echo "# NVM config" >> $USERPATH/.bashrc
	echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> $USERPATH/.bashrc
	echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $USERPATH/.bashrc
    source ~/.bashrc
fi

# install Node.js
. ~/.nvm/nvm.sh 
nvm --version
nvm install node

# bat config
if [ ! -f "$USERPATH/.local/bin/bat" ]; then
sudo apt-get install bat -y
mkdir -p $USERPATH/.local/bin
ln -s /usr/bin/batcat $USERPATH/.local/bin/bat
fi

# packer.nvim install
if [ ! -d "$USERPATH/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

# lua install
if cat "$USERPATH/.bashrc" | grep "# lua" > /dev/null
then
	:
else
mkdir -p ~/Applications
cd ~/Applications
curl -R -O http://www.lua.org/ftp/lua-5.4.4.tar.gz
tar zxf lua-5.4.4.tar.gz
cd lua-5.4.4
make all test
cd ~/Applications
rm -rf lua-5.4.4.tar.gz
cd ~
echo "# lua" >> ~/.bashrc
echo "export PATH=\$PATH:~/Applications/lua-5.4.4/src" >> ~/.bashrc
source ~/.bashrc
fi




else
	:
fi



