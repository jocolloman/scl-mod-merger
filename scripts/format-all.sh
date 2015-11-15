#!/bin/bash
for i in $(ls *.JSON); do
    echo $i
    format-json.sh $i > $i.new
    mv $i.new $i
done
