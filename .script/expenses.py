#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import sys

def expenses(data):
    return sum(map(float, re.findall('\d+\.\d\d?', data)))

def main():
    data = ''.join(sys.stdin.readlines())
    print("Expenses: %.2f" % expenses(data))

if __name__ == "__main__":
    main()

