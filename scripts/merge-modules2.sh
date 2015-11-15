#!/bin/bash
TMP1="/repos/tmp1"
TMP2="/repos/tmp2"
DIR1="/repos/scl-mods/$1"
DIR2="/repos/scl-mods/$2"
TEXT_ASSETS="/repos/SCL-Text-Assets/Mod"

cd /repos/scl-mods/
git pull

if [ ! -e $DIR1 ] ; then
    2&> echo "No such module $1"
    exit 1
fi

if [ ! -e $DIR2 ] ; then
    2&> echo "No such module $2"
    exit 1
fi

cd /repos/
if [ -e $TMP1 ]; then
    rm -rf $TMP1
fi
if [ -e $TMP2 ]; then
    rm -rf $TMP2
fi
mkdir $TMP1
mkdir $TMP2

BRANCH="$1-$2"
cd $TMP1
git clone git@github.com:jocolloman/scl-mod-merge-base.git
cd scl-mod-merge-base
git checkout -b $BRANCH
mkdir Mod
for i in $(ls $DIR1); do
    cp $TEXT_ASSETS/$i $TMP1/scl-mod-merge-base/Mod/$i
done
for i in $(ls $DIR2); do
    cp $TEXT_ASSETS/$i $TMP1/scl-mod-merge-base/Mod/$i
done
git add Mod
git commit -m "Base Files"
git push origin $BRANCH

cd $TMP2
git clone git@github.com:jocolloman/scl-mod-merge-base.git
cd scl-mod-merge-base
git checkout $BRANCH
git pull origin branch
cp -r $DIR2/* Mod/
git add Mod
git commit -m "Added $2"
git push origin $BRANCH

cd $TMP1/scl-mod-merge-base
cp -r $DIR1/* Mod/
git add Mod
git commit -m "Added $1"
git pull --rebase origin $BRANCH
git push origin $BRANCH
