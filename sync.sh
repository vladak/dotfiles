#!/bin/sh

dotfiles_loc=~/dotfiles

if [ ! -d "$dotfiles_loc" ]; then
	echo "no dotfiles in $dotfiles_loc"
	exit 1
fi

# Copy various scripts to ~/bin
if [ ! -d ~/bin ]; then
	mkdir ~/bin
fi
cp -f "$dotfiles_loc"/bin/* ~/bin
if [ $? -ne 0 ]; then
	echo "cannot copy bin files"
	exit 1
fi

# Create dotfiles
for entry in `find $dotfiles_loc/config/ -type f -name '\.*'`; do
	base=`basename $entry`
	if [ -z "$base" ]; then
		continue
	fi
	if [ -f ~/$base -a ! -h ~/$base ]; then
		mv -f ~/$base ~/$base.orig
	fi
	if [ ! -h ~/$base ]; then
		ln -sv "$entry" ~
	fi
done
