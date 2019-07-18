FROM arm32v7/node:6

MAINTAINER info@codingjam.it

RUN npm install -g gulp && \
    npm install -g bower && \
    git clone https://github.com/cosenonjaviste/blogzinga.git

RUN apt-get install libfontconfig1 libfreetype6 && \
    curl -o /tmp/phantomjs_2.1.1_armhf.deb -sSL https://github.com/fg2it/phantomjs-on-raspberry/releases/download/v2.1.1-wheezy-jessie/phantomjs_2.1.1_armhf.deb && \
    dpkg -i /tmp/phantomjs_2.1.1_armhf.deb

RUN apt-get update -y && apt-get install jq

WORKDIR blogzinga

RUN jq 'del(.devDependencies.phantomjs)' package.json > tmp.$$.json && mv tmp.$$.json package.json && cat package.json

RUN npm install
RUN bower install --allow-root --force-latest
RUN npm install gulp

RUN gulp --gulpfile gulpfile_publish.coffee

EXPOSE 8080

CMD /blogzinga/backend/start.js
