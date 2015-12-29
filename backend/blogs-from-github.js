var request = require('request-promise');
var _ = require('underscore');
var Q = require('q');

module.exports = {

    getLastBlogEntries: function getLastBlogEntries(items) {
        return request({
                uri: 'https://raw.githubusercontent.com/cosenonjaviste/blogzinga/master/blogs.json',
                json: true
            })
            .then(function (response) {
                return _.last(response, items).reverse();
            })
            .catch(function (err) {
                console.error(err);
                return Q.reject(err);
            });
    }
}