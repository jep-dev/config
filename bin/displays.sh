#!/bin/bash

find /tmp/.X11-unix -type s -exec echo {} \; -exec lsof {} \;
