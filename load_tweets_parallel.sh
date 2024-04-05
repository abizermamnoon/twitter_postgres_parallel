#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
 
start_time=$(date +%s.%N)
for file in "$files"; do
   echo "$file" | parallel ./load_denormalized.sh
done
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)
echo "Elapsed time: $elapsed_time seconds"
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel
