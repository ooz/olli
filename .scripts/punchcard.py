#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import datetime
import sys
import time

FIVE_MINUTES_IN_SECONDS = 300.0
DATE_FORMAT = '%Y-%m-%d'
DATABASE_FILENAME = ".punchcard.csv"
CSV_SEPARATOR = ','

class Work(object):
    def __init__(self, date, seconds):
        self.date = date
        self.seconds = int(seconds)
    def merge(self, other):
        if self.key() == other.key():
            self.seconds += other.seconds
        return self
    def key(self):
        return self.date
    def __str__(self):
        return f'{self.date},{self.seconds}'

def now():
    return datetime.datetime.now()

def now_date():
    return datetime.date.today().strftime(DATE_FORMAT)

def now_weekday():
    return datetime.datetime.today().weekday()

def dates_for_week(date):
    date_time = datetime.datetime.strptime(date, DATE_FORMAT)
    weekday = now_weekday()
    day_offsets = [day - weekday for day in range(7)]
    dates = [date_time + datetime.timedelta(days=offset) for offset in day_offsets]
    return [f'{d:%Y-%m-%d}' for d in dates]

def format_session(seconds):
    minutes = seconds // 60
    hours = minutes // 60
    if hours > 0:
        return f'{hours}h {minutes % 60}m'
    if minutes > 0:
        return f'{minutes}m {seconds % 60}s'
    return f'{seconds}s'

def difference_in_seconds(start, end):
    return int((end - start).total_seconds())

def print_help_and_exit():
    print(f'''punchcard.py: Time tracker, saves to {DATABASE_FILENAME}
When terminated, prints total working time of today and this week.''')
    sys.exit(0)

def read_db():
    try:
        with open(DATABASE_FILENAME, 'r') as f:
            lines = f.readlines()[1:]
            db = {}
            for line in lines:
                comps = line.strip().split(CSV_SEPARATOR)
                work = None
                if len(comps) >= 2:
                    work = Work(comps[0], comps[1])
                if work:
                    db[work.key()] = work
            return db
    except IOError:
        pass
    return {}

def write_db(db):
    content = 'DATE,SECONDS\n' + '\n'.join([str(work) for work in db.values()]) + '\n'
    with open(DATABASE_FILENAME, 'w') as f:
        f.write(content)

def update_db(work):
    db = read_db()
    if work.key() in db:
        db[work.key()] = db[work.key()].merge(work)
    else:
        db[work.key()] = work
    write_db(db)
    return db

def print_stats(db, start_date):
    other_week_dates = [date for date in dates_for_week(start_date) if date != start_date]
    seconds_today = 0
    seconds_week = 0
    for key in db.keys():
        if key.startswith(start_date):
            seconds_today += db[key].seconds
        for date in other_week_dates:
            if key.startswith(date):
                seconds_week += db[key].seconds
    seconds_week += seconds_today

    n = min(60, len(db))
    n_day_avg = int(float(sum([db[key].seconds for key in list(db.keys())[-n:]])) / n)

    print(f'Today: {format_session(seconds_today)}')
    print(f'This week: {format_session(seconds_week)}')
    print(f'{n}-day average: {format_session(n_day_avg)}')

def main(args):
    if '-h' in args or '--help' in args:
        print_help_and_exit()

    start = now()
    start_date = now_date()
    print(f'Clocking in at  {start}')

    try:
        prev_print = ''
        while True:
            time.sleep(FIVE_MINUTES_IN_SECONDS)
            current = now()
            update_output = format_session(difference_in_seconds(start, current))
            sys.stdout.write('\b' * len(prev_print) + update_output)
            sys.stdout.flush()
            prev_print = update_output

    except KeyboardInterrupt:
        end = now()
        duration_in_seconds = difference_in_seconds(start, end)
        work = Work(start_date, duration_in_seconds)
        db = update_db(work)
        print(f'\nClocking out at {end} (after {format_session(duration_in_seconds)})')
        print_stats(db, start_date)

if __name__ == "__main__":
    main(sys.argv[1:])
