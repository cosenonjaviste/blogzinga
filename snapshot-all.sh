#!/bin/sh
echo 'Snapshotting Home...'
./make-snapshot.sh 'http://localhost:8080/#!/home' home
echo 'Snapshotting Contribute...'
./make-snapshot.sh 'http://localhost:8080/#!/contribute' contribute
echo 'Snapshotting About...'
./make-snapshot.sh 'http://localhost:8080/#!/about' about
