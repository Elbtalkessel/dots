#!/usr/bin/env python3
from subprocess import Popen, PIPE, STDOUT, check_output, check_call
from pathlib import Path
from os import listdir
from os.path import isfile, join, expanduser
import sys

ROFI_SH = expanduser('~/.config/rofi/scripts')
MPC = ['mpc', '--host', expanduser('~/.local/run/mpd.socket')]
ROFI = ['rofi', '-theme', 'themes/appsmenu.rasi']


def getCurrent():
    return check_output([*MPC, "current"]);


current = getCurrent().decode()
if not current:
    current = "Silence"
else:
    current = current.rstrip()


# list of tracks + SOURCES and CONTROL entries
def draw_tlist():
    titles = check_output([*MPC, "playlist"])
    track = 0
    tlist = ""
    tmp = 'SOURCES'
    for line in titles.splitlines():
        track += 1
        tlist = tlist + "[" + str(track) + "] " + line.decode() + "\n"
    if track > 1:
        tlist.rstrip()
        tlist = "[SOURCES]\n[CONTROL]\n" + tlist
        rofi = Popen([*ROFI, "-selected-row", "1", "-i", "-dmenu", "-p", current], stdout=PIPE, stdin=PIPE)
        tmp = rofi.communicate(input=tlist.encode())[0].decode().rstrip()
        tmp = tmp[tmp.find("[") + 1:tmp.find("]")]
    if not tmp:
        sys.exit(0)
    return tmp


# list of directories under ~/Music
def draw_slist():
    commands = "Local ~/Music\nTRACKS\nCONTROL\n"
    playlists = check_output([*MPC, "lsplaylists"])
    for line in playlists.splitlines():
        commands = commands + line.decode() + "\n"
    rofi = Popen([*ROFI, "-i", "-dmenu", "-p", current], stdout=PIPE, stdin=PIPE)
    tmp = rofi.communicate(input=commands.encode())[0].decode().rstrip()
    if not tmp:
        sys.exit(0)
    elif tmp == "Local ~/Music":
        check_call([*MPC, "clear"])
        check_call([*MPC, "update"])
        files = check_output([*MPC, "listall"])
        add = Popen([*MPC, "add"], stdin=PIPE)
        add.communicate(files)
        Popen([*MPC, "play"])
    if tmp in ['TRACKS', 'CONTROL']:
        # if None is passed to the main func it will draw list of tracks
        tmp = tmp if tmp == 'CONTROL' else None
        main(tmp)
    else:
        check_call([*MPC, "clear"])
        check_call([*MPC, "load", tmp])
        check_call([*MPC, "play"])


def draw_controls():
    check_call([join(ROFI_SH, 'mpdmenu.sh')])


def main(selected=None):
    selected = selected or draw_tlist()
    if selected == 'CONTROL':
        draw_controls()
    elif selected == 'SOURCES':
        draw_slist()
    else:
        check_call([*MPC, "play", selected])


main()
