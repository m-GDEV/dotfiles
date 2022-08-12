#! /bin/bash
# in the future maybe make the programs file a parseable file so that I don't have to update both files in the future.
#set -x

# --- Function to install programs ---
function iP() {
# $1 is name of var
# $2 is var
# $3 is package manager
	for i in $2; do
		echo "$i"
	done

	echo -en "\nWould you like to install $1? [y/n] "
	read -r

	if [[ "$REPLY" == "y" ]]; then

		if [[ "$3" == "yay" ]]; then
			"$3" -S $2
		else 
			sudo "$3" -S $2
		fi
		echo "Installed $1."
	else
		echo "Skipping..."
	fi
}

# Function for install requests
function iR(){
	#echo -e "\n${1}: \n\n${2}"; iP "$1" "$2" "$3"
	echo -e "\n${1}:" ; iP "$1" "$2" "$3"
}

# --- Lists of programs (vars starting with "O" are optional, vars including "A" are from the AUR) ---

# Install yay
sudo pacman -S yay

# GUI Programs / A GUI program is anything that is displayed on or interacts with the GUI
GUI="lxappearance xfce4-power-manager xfce4-taskmanager gnome-disk-utility gnome-system-monitor nemo pcmanfm arandr mpv nitrogen pavucontrol polybar unclutter gufw picom redshift noto-fonts-emoji noto-fonts i3-gaps slock scrot numlockx "
OGUI="newsflash vlc kitty onlyoffice-desktopeditors firefox"
AGUI="brave-bin zoom spotify sakura "
OAGUI="x11-emoji-picker audio-recorder gotop youtube-dl-gui-git ttf-ms-fonts simplescreenrecorder"

# Terminal Programs / Programs that the user uses in the terminal
TERP="fortune-mod bat git curl duf lm_sensors exa fd openssh ufw clang libqalculate playerctl lz4 unzip tar the_silver_searcher openssh htop xsel lolcat pv"
OTERP="sox docx2txt ncdu ntfs-3g figlet"
ATERP="syncthing activitywatch-bin"
OATERP="ccrypt minify"

# Text Editors
TE="nano gvim"
OTE="micro atom code"

# Devoloper Programs
DEV="nodejs npm python-pip yarn prettier"


# --- Normal Installations ---
clear

echo -e "\n\nWARNING!! To install an AUR package you must have yay installed.\n\n"

echo "Installing GUI..."
iR "GUI Programs" "$GUI" "pacman"
iR "Optional GUI Programs" "$OGUI" "pacman"
iR "AUR GUI Programs" "$AGUI" "yay"
iR "Optional AUR GUI Programs" "$OAGUI" "yay"
clear

echo "Installing Terminal Programs..."
iR "Terminal Programs" "$TERP" "pacman"
iR "Optional Terminal Programs" "$OTERP" "pacman"
iR "Optional Terminal Programs" "$ATERP" "yay"
iR "AUR Optional Terminal Programs" "$OATERP" "yay"
clear

echo "Installing Text Editors..."
iR "Text Editors" "$TE" "pacman"
iR "Optional Text Editors" "$OTE" "pacman"
clear

echo "Installing Developer Programs..."
iR "Devoloper Programs" "$DEV" "pacman"

# --- Alternate program installations ---
ALT="starship bash-insulter fzf m-GDEV-dmenu mpv-mpris vim-plug zoxide ifetch"
echo "ALT: $ALT"
echo -en "\n\nWould you like to install the programs with alternate installation methods? [y/n] "
read -r
if [[ "$REPLY" == "y" ]]; then
	echo "Installing Starship..."
	sh -c "$(curl -fsSL https://starship.rs/install.sh)"

	echo "Installing Bash-Insulter"
	sudo wget -O /etc/bash.command-not-found https://raw.githubusercontent.com/hkbakke/bash-insulter/master/src/bash.command-not-found

	echo "Installing fzf..."
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
	
	echo "Installing m-GDEV-dmenu"
	git clone https://github.com/m-GDEV/m-GDEV-dmenu.git /tmp/dmenu
	cd /tmp/dmenu
	sudo make install

	echo "Installing mpv-mrpris"
	if ! command -v mpv &> /dev/null; then
		echo "mpv is not installed, please install it and try again."
    else
	    git clone https://github.com/hoyon/mpv-mpris.git /tmp/mpv-mpris
	    cd /tmp/mpv-mpris
	    sudo make install
	fi

	echo "Installing vim-plug"
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	echo "Installing zoxide"
	curl -sS https://webinstall.dev/zoxide | bash

    echo "Installing ifetch"
    curl -L https://raw.githubusercontent.com/m-GDEV/ifetch/master/install | bash

else
	echo "Skipping..."
fi

# --- Closing ---
echo -e "\n\n\nInstallation Finished. Feel free to re-run this script again the install groups of packages you missed!\n"
