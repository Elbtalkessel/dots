#!/bin/python3.7

import os


BASE_DIR=os.path.expanduser('~')
MUSIC_DIR=os.path.join(BASE_DIR, 'Music')
PL_DIR=os.path.join(BASE_DIR, 'Playlists')


def subwalk(dir):
    paths = []
    for base_dir, sub_dirs, files in os.walk(dir):
        for file in files:
            if not file.endswith(('mp3', 'flac')):
                continue
            p = f'{base_dir}/{file}'
            paths.append(p.replace(MUSIC_DIR + '/', ''))
    return paths


def rootwalk(dir):
    chkdirs = [n for n in os.listdir(dir) if os.path.isdir(os.path.join(dir, n))]
    for rootdir in chkdirs:
        yield subwalk(os.path.join(dir, rootdir))


if __name__ == '__main__':
    for fpaths in rootwalk(MUSIC_DIR):
        if not fpaths:
            continue
        pl_name = fpaths[0].split('/')[0] + '.m3u'
        pl_path = os.path.join(PL_DIR, pl_name)
        with open(pl_path, 'w') as f:
            for fpath in fpaths:
                f.write(fpath + '\n')

