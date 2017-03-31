#!/usr/bin/zsh

mode=${1:-'thin'}
if [ "$mode" = 'thin' ]; then
	date +\ %H:%M:%S\ %a%b\ %e | wrap-to 3
else
	date +\ %H:%M:%S%n%A,\ %B\ %e,\ %Y
fi
