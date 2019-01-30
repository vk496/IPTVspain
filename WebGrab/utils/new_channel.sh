#!/bin/sh


read -p "Logo: " logo
read -p "Name: " name
read -p "EPG: " epg
read -p "m3u8: " m3u8
read -p "Categoría: " categ

echo "|<img src=\"$logo\" width=\"128\"/> |$name|$epg|[m3u8]($m3u8)|$categ|"
