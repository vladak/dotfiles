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

# Create dotfiles in home directory.
for entry in `find $dotfiles_loc/config/ -maxdepth 1 -name '\.*'`; do
	base=`basename $entry`
	if [ -z "$base" ]; then
		continue
	fi

	dst=~/$base

	if [ ! -h $dst -a \( -f $dst -o -d $dst \) ]; then
		rm -rf ~/"$base.orig"
		mv -f $dst ~/$base.orig
	fi
	if [ ! -h $dst ]; then
		ln -sv "$entry" ~
	fi
done
