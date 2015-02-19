## BlogZinga! ##

Find your favorite blogs here!

[http://www.blogzinga.it](http://www.blogzinga.it)

### How to contribute ###
* Fork this repo
* Add your favorite blogs to [blogs.json](https://github.com/cosenonjaviste/blogzinga/blob/master/blogs.json)
* Aks for a Pull Request, we will merge ASAP

### How to build ###
* install [node.js](http://nodejs.org/)
* in *root* folder
```
npm install && bower install
```
* in *backend* folder
```
npm install
```
### How to lauch ###
* in *root* folder
```
gulp
```
If gulp is not installed on your computer, you should install it using the command:
```
npm install -g gulp
```

If the execution of the command gulp generates errors, this may be due to the lack of some dependencies that should be installed via npm:
```
npm install static-favicon
npm install morgan
npm install cookie-parser
npm install body-parser
```

Check your browser at
  http://localhost:8000/

### Notes to proxy network
In the case where your computer is connected to a network with a proxy server, then you should set npm, bower and git to use the proxy server. The way to configure nmp is the following:
```
npm config set proxy http://proxy.company.com:8080
npm config set https-proxy http://proxy.company.com:8080
```
If you need to specify credentials, they can be passed in the url using the following syntax:
```
http://user_name:password@proxy.company.com:8080
```

 You can also set the proxy configuration as a command line argument or environment variable. Further exploration of the [https://npmjs.org/doc/config.html](npm config documentation) showed that the npm config set command sets the proxy configuration in your .npmrc file.


Bower can be configured using JSON in a [http://bower.io/docs/config/#bowerrc-specification](.bowerrc) file. The way to configure proxy is the following (content of .bowerrc):
```
{
  "proxy": "http://proxy.company.com:8080",
  "https-proxy": "http://proxy.company.com:8080"
}
```

For git set the proxy configuration in this way:
```
git config --global http.proxy http://proxy.company.com:8080
git config --global https.proxy http://proxy.company.com:8080
```

When under a proxy, you must configure git to use https:// instead of git://.
You can configure it for every endpoint or for this specific host as follows:
```
git config --global url."https://".insteadOf git://
git config --global url."https://gist.github.com".insteadOf git://gist.github.com
```

