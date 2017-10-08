#!/bin/bash
/usr/bin/pulseaudio --check
/usr/bin/pulseaudio -k
/usr/bin/pulseaudio --log-level=4 --log-target=stderr -v
