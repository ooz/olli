#!/usr/bin/python

import sys
import os

args = sys.argv[1:]

os.system("cal")

if ("-7" in args):
    os.system("calendar -A 7")

if ("-14" in args or len(args) == 0):
    os.system("calendar -A 14")

if ("-30" in args):
    os.system("calendar -A 30")

if ("-31" in args):
    os.system("calendar -A 31")
