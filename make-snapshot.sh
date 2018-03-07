#!/bin/sh
url=$1
final_path=$2
base_path=./dist/snapshots
mkdir -p $base_path
phantomjs ./bower_components/AngularJS-SEO-Article/.phantomjs-runner.js $url > $base_path/$final_path
