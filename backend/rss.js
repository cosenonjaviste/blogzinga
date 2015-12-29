var RSS = require('rss');
var blogService = require('./blogs-from-github');

module.exports = {

    getFeed: function fetFeed() {
        return blogService.getLastBlogEntries(10)
            .then(function (blogs) {

                var feed = new RSS({
                    title: 'BlogZinga!',
                    description: 'La lista dei blog di programmatori italiani. By CoseNonJaviste',
                    feed_url: 'http://blogzinga.it/feed/rss',
                    site_url: 'http://blogzinga.it',
                    image_url: 'http://www.cosenonjaviste.it/wp-content/uploads/2015/05/bz.png',
                    managingEditor: 'CNJ Community',
                    language: 'it',
                    categories: ['Developer', 'Blog'],
                    ttl: 1440
                });

                blogs.forEach(function (blog) {
                    feed.item({
                        title: blog.title,
                        description: blog.topic,
                        url: blog.url,
                        categories: blog.tags,
                        author: blog.authors.join(',')
                    });
                });

                return feed;
            });
    }

};

