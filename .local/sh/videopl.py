#!/bin/python3

import os

BASE_DIR = os.path.expanduser('~')
VIDEO_DIR = os.path.join(BASE_DIR, 'Videos')
PL_DIR = os.path.join(BASE_DIR, 'VideoPlaylists')
PL_EXT = '.vpl'

VIDEO_FORMATS = ('mp4',)


def main():
    for current_dir, sub_dirs, files in os.walk(VIDEO_DIR):
        video_files = [f for f in files if f.endswith(VIDEO_FORMATS)]
        video_paths = [
            os.path.join(VIDEO_DIR, current_dir, v) + '\n' for v in video_files
        ]
        if video_paths:
            pl_file = os.path.basename(current_dir) + PL_EXT
            parent_dir = os.path.dirname(current_dir)
            rel_parent_dir_path = parent_dir.replace('./', '', 1)
            rel_parent_dir_path = rel_parent_dir_path.replace(VIDEO_DIR + '/', '')
            pl_dir = os.path.join(PL_DIR, rel_parent_dir_path)
            try:
                os.makedirs(pl_dir)
            except Exception:
                pass
            plf = os.path.join(pl_dir, pl_file)
            with open(plf, 'a+') as f:
                f.writelines(video_paths)


if __name__ == '__main__':
    main()

