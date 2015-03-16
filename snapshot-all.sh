#!/bin/sh
echo 'Snapshotting Home...'
./make-snapshot.sh 'http://www.blogzinga.it/#!/home' home
echo 'Snapshotting Contribute...'
./make-snapshot.sh 'http://www.blogzinga.it/#!/contribute' contribute
echo 'Snapshotting About...'
./make-snapshot.sh 'http://www.blogzinga.it/#!/about' about