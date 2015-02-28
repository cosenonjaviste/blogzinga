#!/bin/sh
U=$1
#P=$( echo "$U" | perl -MURI -le 'chomp($url = <>); print URI->new($url)->fragment' )
final_url=$U
P=${P:1}
final_path=$2
base_path=./dist/snapshots
mkdir -p $base_path
phantomjs ./bower_components/AngularJS-SEO-Article/.phantomjs-runner.js $final_url > $base_path/$final_path
