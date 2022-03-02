#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''Reads all birthdays from a people DB and prints them sorted by month-day

https://docs.python.org/3/library/configparser.html
'''

from configparser import ConfigParser
from pathlib import Path
import time

PEOPLE_FILE = Path(__file__).resolve().parent / "people.txt"

def today():
    now = time.localtime()
    return time.strftime('%Y-%m-%d', now)

def main():
    config = ConfigParser()
    config.read(PEOPLE_FILE)

    birthdays = []
    for section_title in config.sections():
        section = config[section_title]
        bday = section.get('bday', section.get('birthday', None))
        if bday:
            birthdays.append(f'''{bday} {section_title}''')

    birthdays.append(f'''{today()} ----------TODAY----------''') # Today marker
    birthdays = sorted(birthdays, key=lambda k: k[5:10]) # Sort by month-day, ignore year
    for bday in birthdays:
        print(bday)

if __name__ == "__main__":
    main()
