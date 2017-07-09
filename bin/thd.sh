#!/bin/zsh

pidof thd >/dev/null || \
	thd --daemon --user john \
		--socket /var/run/thd.socket --pidfile /var/run/thd.pid \
		--triggers /home/john/triggerhappy.conf /dev/input/event* \
		&& { pidof thd >/dev/null || echo 'Test contains false negatives' }
