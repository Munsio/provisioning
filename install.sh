#!/bin/bash

cd "$(dirname "$0")"

ZSH_FIRST_RUN=true

function init {
	echo "##########################################"
	echo "##                                      ##"
	echo "##    Munsio's - Base Server install    ##"
	echo "##                                      ##"
	echo "##########################################"
	echo ""
	echo "!! Be sure to run this script as root or sudo !!"
	echo ""
	echo "Do you want to continue?"
	select yn in "Yes" "No"; do
	    case $yn in
	        Yes ) break;;
	        No ) exit;;
	    esac
	done
}


function startUpdating {

	echo ""
	echo "##########################################"
	echo "##                                      ##"
	echo "##   Update and install base programs   ##"
	echo "##                                      ##"
	echo "##########################################"
	echo ""

	apt-get update && apt-get upgrade

	apt-get install git vim zsh curl sudo wget htop

	echo "finished installing base programs"
}

function installOhMyZsh {

	echo ""
	if $ZSH_FIRST_RUN; then
		ZSH_FIRST_RUN=false
		echo "Do you want to install oh-my-zsh?"
		select yn in "Yes" "No"; do
		    case $yn in
		        Yes )	execOhMyZshAsUser $USER
						break;;
		        No ) break;;
		    esac
		done
	else
		echo "Do you want to install oh-my-zsh for another user?"
		select yn in "Yes" "No"; do
		    case $yn in
		        Yes )	read -p " Username: " Username
						execOhMyZshAsUser $Username
						break;;
		        No ) return;;
		    esac
		done
	fi

	installOhMyZsh

}


function execOhMyZshAsUser {

	ret=false
	id -u $1 >/dev/null 2>&1 && ret=true

	if $ret; then
		su $1 installOhMyZsh.sh $1
		echo "oh-my-zsh for $1 installed"
	else
	    echo "User does not exist - abort"
	fi

}


init
startUpdating
installOhMyZsh
echo "Installation process finished - good luck & have fun"
exit
