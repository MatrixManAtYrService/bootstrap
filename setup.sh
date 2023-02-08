# don't run this like a script, source it like:
#    . setup.sh
if which nix
then
    echo nix is already installed
else
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
fi
. $HOME/.nix-profile/etc/profile.d/nix.sh

if which home-manager
then
    echo home-manager is already installed
else
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
fi

home-manager switch

if ! grep 'nix-command flakes' ~/.profile &> /dev/null
then
    echo 'alias nix="nix --experimental-features \"nix-command flakes\""' >> ~/.profile
fi
source ~/.profile

