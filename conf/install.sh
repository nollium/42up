#!/bin/sh

sudo cp ./42up.service /etc/systemd/system/. && sudo systemctl enable --now 42up
systemctl status 42up
