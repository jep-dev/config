#!/bin/bash

# echo "User: $USER"

# --triggers /home/john/.triggerhappy.conf \
thd --daemon --user john \
	--socket /var/run/thd.socket \
	--pidfile /var/run/thd.pid \
	--triggers /home/john/triggerhappy.conf \
	/dev/input/event*
# --user nobody
