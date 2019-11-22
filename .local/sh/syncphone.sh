if [ "$#" -lt 3 ]; then
    echo "usage: <u|d> <e|i> <directory>"
    echo "u: from pc to phone"
    echo "d: from phone to pc"
    echo "e: use phone sdcard"
    echo "i: use phone internal memmory"
    exit 0
fi

LOC_ROOT=/media/risus/data
REM_ROOT_EXT=phone:/storage/493A-1606
REM_ROOT_INT=phone:/storage/emulated/0

if [ "$1" = "u" ]; then
    BASE_SRC=$LOC_ROOT
    if [ "$2" = "e" ]; then
        BASE_DST=$REM_ROOT_EXT
    else
        BASE_DST=$REM_ROOT_INT
    fi
else
    BASE_DST=$LOC_ROOT
    if [ "$2" = "e" ]; then
        BASE_SRC=$REM_ROOT_EXT
    else
        BASE_SRC=$REM_ROOT_INT
    fi
fi

echo "$BASE_SRC/$3/ -> $BASE_DST/$3"
if [ "$#" -eq 3 ]; then
    rsync -Prv "$BASE_SRC/$3/" "$BASE_DST/$3"
fi

