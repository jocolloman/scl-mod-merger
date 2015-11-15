#!/bin/bash
TMP="/tmp"
DIR="/repos/scl-mods/$1"
TEXT_ASSETS="/repos/SCL-Text-Assets/Mod"
if [ -e $DIR ]
then
    echo "Module $1 already exists."
    exit 1
fi

if [ -e $TMP ]; then
    rm -rf $TMP
    mkdir $TMP
fi

if [-e $DIR]; then
    >&2 echo "Repository for $DIR already exists"
    exit 1
fi

mkdir $DIR
unzip $1 -d $TMP

cd $TMP

for i in $(ls); do
    # IF the file is in the base assets it is okay to mod
    if [ -e $TEXT_ASSETS/$i ]; then
	cp $TEXT_ASSETS/$i $DIR/$i
	continue
    fi
    
    # Invalid file found
    >&2 echo "Found file $i which doesn't correspond with any Text Asset"
    rm $DIR -rf
    exit 1
done

format-all.sh

cd $DIR; cd ..
git pull
git add $DIR
git commit -m "Initial $1"
git push

cp $TMP/* $DIR
git add $DIR
git commit -m "Updated $1"
git push
