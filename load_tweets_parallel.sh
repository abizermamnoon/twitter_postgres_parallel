#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
 

echo "$files" | time parallel sh load_denormalized.sh
#done
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
    echo
    # copy your solution to the twitter_postgres assignment here
echo "$files" | time parallel python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:8632/ --inputs

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel

echo "$files" | time parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:6627/ --inputs
