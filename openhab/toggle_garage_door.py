#!/usr/bin/env python

### this requires an entry in /etc/openhab/misc/exec.whitelist

import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(2,GPIO.OUT)
GPIO.output(2,GPIO.LOW)
time.sleep(0.5)
GPIO.output(2,GPIO.HIGH)