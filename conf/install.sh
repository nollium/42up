#!/bin/sh

sudo cp ./42up.service /etc/systemd/system/. && sudo sytemctl enable --now 42up
