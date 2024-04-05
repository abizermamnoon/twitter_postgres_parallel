#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
start_time=$(date +%s.%N)
for file in $files; do
    echo
    unzip -p "$file" | sed 's/\\u0000//g' | psql postgresql://postgres:pass@localhost:14082 -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';" 
done
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)

# Display elapsed time
echo "Elapsed time: $elapsed_time seconds"
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
start_time=$(date +%s.%N)
for file in $files; do
    echo
    # copy your solution to the twitter_postgres assignment here
    python3 load_tweets.py --db=postgresql://postgres:pass@localhost:8632 "--inputs=$file"
done
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)
echo "Elapsed time: $elapsed_time seconds"
echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
start_time=$(date +%s.%N)
for file in $files; do
   python3 load_tweets_batch.py --db=postgresql://postgres:pass@localhost:6627/ --inputs $file
done
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)
echo "Elapsed time: $elapsed_time seconds"
