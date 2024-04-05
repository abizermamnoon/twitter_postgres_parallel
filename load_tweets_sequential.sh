#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
for file in $files; do
    echo
    time unzip -p "$file" | sed 's/\\u0000//g' | psql postgresql://postgres:pass@localhost:14082 -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';" 
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
for file in $files; do
    echo
    # copy your solution to the twitter_postgres assignment here
    time python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:8632 "--inputs=$file"
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
for file in $files; do
    time python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:6627/ --inputs $file
done
