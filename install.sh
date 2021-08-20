#!/usr/bin/env sh

# Check for install-tl/ folder reuse {{{
if [ -d install-tl/ ]; then
    echo "TeX Live folder already exists."
    printf "Delete folder and re-download? Saying no re-uses folder. (y/N): "
    read -r confirmation

    if [ "$confirmation" ] && echo "$confirmation" | grep -E '^[Yy]$' > /dev/null; then
        echo "Deleting existing TeX Live installer folder"
        \rm -rf install-texlive-unix.tar.gz install-tl/ || exit

    fi
fi
# Check for install-tl/ folder reuse }}}


# Download and Extract TeX Live Installer {{{
if [ ! -d install-tl/ ]; then
    curl -L https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -o install-texlive-unix.tar.gz
    tar xfz install-texlive-unix.tar.gz
    mv install-tl-* install-tl || exit
fi
# Download and Extract TeX Live Installer }}}


# Install TeX live {{{
ln -sf ../texlive.profile install-tl/texlive.profile
cd install-tl/ || exit

./install-tl --profile=texlive.profile
# Install TeX live }}}
