#!/bin/bash

res_pattern='\([0-9]*x[0-9]*\)'
res=$(xdpyinfo | sed -n 's/[ ]*dimensions:[ ]*'"$res_pattern"'.*/\1/p')
xdotool search --onlyvisible . 2>/dev/null | { \
	while read i; do \
		xdotool getwindowgeometry $i | \
		sed -n 's/Window \([0-9]*\)\|Geometry: '"$res_pattern"'/\1\2/p' | {
			read j && read k && [ "$k" = "$res" ] && \
				xdotool windowminimize $i;
	}; done; }
