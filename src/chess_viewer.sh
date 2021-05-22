#!/bin/bash

echo "Welcome to Chess Viewer"
echo "Would you like to load your own PGN file? (y/n)"
read CHOICE

if ($CHOICE == "y")
then
    echo "Enter the file path your .pgn file: "
    read PGN
else
    echo "Program will use default file"
    PGN="pgn/FischerVsThomason.pgn"
fi

echo "Enter how many seconds to wait between moves in seconds"
read TIME

ruby index.rb -t $TIME -p $PGN
