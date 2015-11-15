#!/bin/bash

TEXT_ASSETS="/repos/SCL-Text-Assets/Mod"

TMP="/tmp"
BASE="$TMP/scl-mod-merge-base"
BRANCH="branch"

if [ -e $TMP ]; then
    rm $TMP -rf
fi

mkdir $TMP
cd $TMP

# Build up Base Files
git clone git@github.com:jocolloman/scl-mod-merge-base.git
cd $BASE
git checkout -b $BRANCH
mkdir Mod

for MODULE in $@; do
    DIR=/repos/scl-mods/$MODULE
    for file in $( ls $DIR ); do
	if [ ! -e $BASE/Mod/$file ]; then
	    cp $TEXT_ASSETS/$file Mod/$file
	fi
    done
done

git add Mod
git commit -m "Base Files"
git push origin $BRANCH

# Add each mod individually
for MODULE in $@; do
    TMP_DIR=$TMP/$MODULE
    DIR=/repos/scl-mods/$MODULE
    if [ -e $TMP_DIR ]; then
       >2& echo "Duplicate module!"
       exit 1
    fi
       
    mkdir $TMP_DIR
    cd $TMP_DIR

    git clone git@github.com:jocolloman/scl-mod-merge-base.git
    cd scl-mod-merge-base
    git checkout $BRANCH
    git pull origin branch
    cp -r $DIR/* Mod/
    git add Mod
    git commit -m "Added $MODULE"
    
done

# Merge each module
for MODULE in $@; do
    cd $TMP/$MODULE/scl-mod-merge-base
    git pull --rebase origin $BRANCH
    git push origin $BRANCH
done    
