#!/bin/bash



# Please set up the network proxy first

USERPATH=/home/maoyp


if uname -a | grep "Ubuntu" > /dev/null
then

# update sys
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y 

# set /etc/hosts
#if cat "/etc/hosts" | grep "raw.githubusercontent.com" > /dev/null
#then
#	:
#else
#	echo "199.232.28.133 raw.githubusercontent.com" >> /etc/hosts
#fi

# install neovim
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
git clone https://github.com/neovim/neovim
cd neovim && make
sudo make install
if [ ! -f "$USERPATH/.config/nvim/init.vim" ]; then
mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.lua
fi


sudo apt-get install git -y

# install plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# FZF
if [ ! -d "$USERPATH/.fzf" ]; then
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$USERPATH/.fzf/install 
source $USERPATH/.bashrc
fi

sudo apt-get install minicom -y
sudo apt-get install curl -y
sudo apt-get install file -y
sudo apt-get install wget -y
sudo apt-get install net-tools -y
sudo apt-get install python3 python3-pip -y

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
if cat "$USERPATH/.bashrc" | grep "# NVM config" > /dev/null
then
	echo "NVM was installed"
	echo "NVM_DIR=$NVM_DIR"
else
	echo "# NVM config" >> $USERPATH/.bashrc
	echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> $USERPATH/.bashrc
	echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $USERPATH/.bashrc
fi

source ~/.bashrc

. ~/.nvm/nvm.sh 
nvm --version
nvm install node

# bat config
sudo apt-get install bat -y
if [ ! -f "$USERPATH/.local/bin/bat" ]; then
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
mkdir -p ~/.config/nvim/lua
cd ~
fi

# packer.nvim config 
if [ ! -f "$USERPATH/.config/nvim/lua/init-packer.lua" ]; then
    cp 
else

fi



else
	:
fi



