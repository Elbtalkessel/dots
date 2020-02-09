#!/bin/env python3
import argparse
from collections import defaultdict
import csv
import re
import os


def main():
    args = argparse.ArgumentParser()
    args.add_argument('-c', help='Path to csv file')
    args.add_argument('--trac', help='Issue tracker', default='')
    args = args.parse_args()
    byissue = defaultdict(lambda: {'Spent': 0, 'Rate': 0.0, 'Issue': ''})
    with open(args.c, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if not row['Date']:
                continue
            issue = f'{row["Project"]}-{row["Activity"]}'
            issue_url = f'{args.trac}{issue}'
            byissue[issue]['Spent'] += int(row['Duration'])
            byissue[issue]['Rate'] += int(re.findall(r'\d+', row['Rate'])[0])
            byissue[issue]['Issue'] = issue_url.replace('#', '')
    basename = os.path.basename(args.c)
    path = os.path.dirname(args.c)
    outpath = os.path.join(path, f'out.{basename}')
    with open(outpath, 'w') as f:
        writer = csv.DictWriter(f, ['Spent', 'Rate', 'Issue'])
        writer.writeheader()
        out = byissue.values()
        out = sorted(out, key=lambda o: o['Issue'])
        writer.writerows(out)
    print('Out:', outpath)


if __name__ == '__main__':
    main()
