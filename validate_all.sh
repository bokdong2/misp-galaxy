#!/bin/bash

set -e
set -x

./jq_all_the_things.sh

diffs=`git status --porcelain | wc -l`

if ! [ $diffs -eq 0 ]; then
	echo "Please make sure you run ./jq_all_the_things.sh before commiting."
	exit 1
fi

for dir in clusters/*.json
do
  echo -n "${dir}: "
  jsonschema -i ${dir} schema_clusters.json
  echo ''
done

for dir in galaxies/*.json
do
  echo -n "${dir}: "
  jsonschema -i ${dir} schema_galaxies.json
  echo ''
done

