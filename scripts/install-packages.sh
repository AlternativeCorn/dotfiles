function install_yay() {

    git clone https://aur.archlinux.org/yay-git # Get yay

    cd $PWD/yay-git
    makepkg -si --noconfirm # Install yay
    cd ..

    rm -rf $PWD/yay-git # Remove yay build files

}

# Setup pacman
cat $PWD/etc/pacman.conf | sudo tee /etc/pacman.conf

sudo pacman -Syu # update system
sudo pacman -S base-devel git

install_yay

sudo pacman -S --noconfirm $(cat $PWD/packages/required/pacman.pkg)

yay -S $(cat $PWD/packages/required/aur.pkg)