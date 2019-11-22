#!/bin/python3

import os


VIDEO_FORMATS = ('mp4',)
VIDEO_DIR = 'Videos'
VIDEO_PAR = os.path.expanduser('~')
WORK_DIR = os.path.join(VIDEO_PAR, VIDEO_DIR)
PL_DIR = os.path.join(WORK_DIR, 'pl')


def main():
    for current_dir, sub_dirs, files in os.walk(WORK_DIR):
        video_files = [f for f in files if f.endswith(VIDEO_FORMATS)]
        video_paths = [
            os.path.join(WORK_DIR, current_dir, v) + '\n' for v in video_files
        ]
        if video_paths:
            pl_file = os.path.basename(current_dir) + '.pl'
            parent_dir = os.path.dirname(current_dir)
            rel_parent_dir_path = parent_dir.replace('./', '', 1)
            rel_parent_dir_path = rel_parent_dir_path.replace(WORK_DIR + '/', '')
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

