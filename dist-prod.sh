#!/bin/sh
gulp --gulpfile gulpfile_publish.coffee
./make-snapshot.sh 'http://www.blogzinga.it/#!/home' home
./make-snapshot.sh 'http://www.blogzinga.it/#!/contribute' contribute
./make-snapshot.sh 'http://www.blogzinga.it/#!/about' about

