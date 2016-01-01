var expect = require('chai').expect;
var blogService = require('../backend/blogs-from-github');

describe('Get Blogs from GitHub', function () {

    it('should return last 10 blogs entry', function (done) {
        var items = 10;
        blogService.getLastBlogEntries(items)
            .then(function (blogs) {
                expect(blogs).is.a('array');
                expect(blogs).to.have.property('length', items);
            })
            .done(done)
    });
});