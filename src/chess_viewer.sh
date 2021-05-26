#!/bin/bash

get_y_or_n () {
    read CHOICE

    until [ $CHOICE = "y" ] || [ $CHOICE = "n" ]; do
    echo "Incorrect Input. Please type 'y' for yes or 'n' for no"
    read CHOICE
    done

    if [ $CHOICE = "y" ]
    then 
        RET=1
    else
        RET=0
    fi

    echo $RET
}

echo "Welcome to Chess Viewer"
echo "Is this your first time using the application? (y/n)"

CHOICE=$(get_y_or_n)

if [ $CHOICE -eq 1 ]
then
    bundle install
fi

echo "Would you like to load your own PGN file? (y/n)"

CHOICE=$(get_y_or_n)

if [ $CHOICE -eq 1 ]
then
    echo "Enter the file path to your .pgn file: "
    echo "If located in the pgn folder, type in the format: 'pgn/<filename>.pgn'"
    read PGN
    if [[ -f $PGN ]]; then
        echo "File Found."
    else
        echo "File not Found. Loading Default instead (FischerVsThomason)."
        PGN="pgn/FischerVsThomason.pgn"
    fi
else
    echo "Program will use default file (FischerVsThomason)."
    PGN="pgn/FischerVsThomason.pgn"
fi

echo "Enter how many seconds to wait between moves in seconds"
read TIME

ruby index.rb -t $TIME -p $PGN
