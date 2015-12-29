## Info su OpenShift ##

### Hooks ###

[http://openshift.github.io/documentation/oo_user_guide.html#action-hooks](http://openshift.github.io/documentation/oo_user_guide.html#action-hooks)

### File System###

[https://developers.openshift.com/en/managing-filesystem.html](https://developers.openshift.com/en/managing-filesystem.html)

## Info sul server ##

Accedere in ssh con 

```
ssh 563e94807628e12f2b00013d@nodejs-gitmap.rhcloud.com
```

File di log:

```
tail -f -n1000 $OPENSHIFT_LOG_DIR/nodejs.log
```