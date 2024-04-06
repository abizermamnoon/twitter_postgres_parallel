#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
 

time for file in "$files"; do
   echo "$file" | parallel ./load_denormalized.sh
done
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
time for file in $files; do
    echo
    # copy your solution to the twitter_postgres assignment here
    echo "$file" | parallel python3 load_tweets.py --db=postgresql://postgres:pass@localhost:8632 "--inputs={}"
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel
time for file in $files; do
   echo "$file" | parallel -j 80 python3 load_tweets_batch.py --db=postgresql://postgres:pass@localhost:6627/ --inputs $file
done
