#!/bin/bash
sed ':a;N;$!ba;s/\n/ /g' $1 | python -m json.tool
