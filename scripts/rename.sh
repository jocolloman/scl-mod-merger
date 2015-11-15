#!/bin/bash

for i in $(ls *.xml); do
    mv $i "`basename $i .xml`"
done
