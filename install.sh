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
	echo "Greetings my friend what do you want to install?"
	echo ""
	select option in \
			"Base programs" \
			"Newest docker system" \
			"oh-my-zsh" \
			"exit";
		do
	    case "$REPLY" in
	        1 ) installBasePrograms;;
			2 ) installDocker;;
			3 ) installOhMyZsh;;
	        4 ) exit;;
	    esac
	done
}

function installBasePrograms {

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

function installDocker {

	echo ""
	echo "##########################################"
	echo "##                                      ##"
	echo "##   Installing newest docker-engine    ##"
	echo "##                                      ##"
	echo "##########################################"
	echo ""

	apt-get install apt-transport-https ca-certificates

	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

	echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list

	apt-get update

	apt-get install docker-engine

	echo "finished installing newest docker-engine"
}

function installOhMyZsh {

	echo ""
	echo "##########################################"
	echo "##                                      ##"
	echo "##         Installing oh-my-zsh         ##"
	echo "##                                      ##"
	echo "##########################################"
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

while true; do
	init
done