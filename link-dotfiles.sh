#!/bin/sh

# shell
if [ ! -e ~/.commonrc ]; then
	ln -sf ~/dotfiles/.commonrc ~/.commonrc
	echo "[+] .commonrc linked"
else
	echo "[=] .commonrc exists"
fi

if [ ! -e ~/.bashrc ]; then
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	echo "[+] .bashrc linked"
else
	echo "[=] .bashrc exists"
fi

if [ ! -e ~/.bash_profile ]; then
	ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
	echo "[+] .bash_profile linked"
else
	echo "[=] .bash_profile exists"
fi

# zsh
# if [ ! -e ~/.zprofile ]; then
# 	ln -sf ~/dotfiles/.profle ~/.zprofile
# 	echo "[+] .zprofile linked"
# else
# 	echo "[=] .zprofile exists"
# fi

if [ ! -e ~/.zshrc ]; then
	ln -sf ~/dotfiles/.zshrc ~/.zshrc
	echo "[+] .zshrc linked"
else
	echo "[=] .zshrc exists"
fi

#if [ ! -e ~/.profile ]; then
#	ln -sf ~/dotfiles/.profile ~/.profile
#	echo "[+] .profile linked"
#else
#	echo "[=] .profile exists"
# 	#echo "renaming it .profile.original"
# 	#mv ~/.profile ~/.profile.original
# 	#ln -sf ~/dotfiles/.profile ~/.profile
# 	#echo "[+] .bash_profile linked"
# fi

if [ ! -e ~/.aliasrc ]; then
	if [ ! -e ~/dotfiles/.aliasrc ]; then
		ln -sf ~/dotfiles/.aliasrc ~/.aliasrc
		echo "[+] .aliasrc linked"
	else
		echo "[=] ~/dotfiles/.aliasrc not found"
	fi
else
	echo "[=] .aliasrc exists"
fi

# vim
if [ ! -e ~/.vimrc ]; then
	ln -sf ~/dotfiles/.vimrc ~/.vimrc
	echo "[+] .vimrc linked"
else
	echo "[=] .vimrc exists"
fi

if [ ! -d ~/.vim ]; then
	ln -sf ~/dotfiles/.vim ~/.vim
	echo "[+] .vim linked"
else
	echo "[=] .vimrc exists"
fi

# tmux
if [ ! -e ~/.tmux.conf ]; then
	ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
	echo "[+] .tmux.conf linked"
else
	echo "[=] .tmux.conf exists"
fi

## etc
#ln -sf ~/dotfiles/.wgetrc ~/.wgetrc

