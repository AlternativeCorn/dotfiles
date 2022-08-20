sudo pacman -S --noconfirm $(cat $PWD/packages/optional/pacman.pkg)
yay -S $(cat $PWD/packages/optional/aur.pkg)
