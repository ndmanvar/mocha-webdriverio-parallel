var chai = require("chai"),
    webdriverio = require("webdriverio");

var expect = chai.expect,
    url = "http://nfl.com/",
    sauceConfig = {
        desiredCapabilities: {
            browserName: "chrome",
            version: "27",
            platform: "XP",
            tags: ["examples"],
            name: "This is an example test"
        },
        host: "ondemand.saucelabs.com",
        port: 80,
        user: process.env.SAUCE_USERNAME,
        key: process.env.SAUCE_ACCESS_KEY,
        logLevel: "silent"
    };

describe("NFL", function () {
    describe("Homepage", function () {
        this.timeout(99999999);
        var client = {};

        before(function (done) {
            client = webdriverio.remote(sauceConfig);
            client.init(done);
        });

        after(function (done) {
            client.end(done);
        });

        it("has the correct title", function (done) {
            client
                .url(url)
                .getTitle(function (err, title) {
                    expect(err).to.not.exist;
                    expect(title).to.be.equal("NFL.com - Official Site of the National Football League");
                })
                .call(done);
        });
        it("logs in the user", function (done) {
            client
                .url(url)
                .waitForExist(".sign-in", 5000)
                .click(".sign-in")
                .element(".yui3-modal-login-iframe").then(function (res) {
                    client.frame(res.value);
                    client.setValue("#registration-username", process.env.USERNAME);
                    client.setValue("#registration-password", process.env.PASSWORD);
                    client.click(".submit .button-royal-blue");
                    client.frame(null);
                })
                .pause(10000)
                .getText(".user-profile-link", function (err, text) {
                    expect(err).to.not.exist;
                    expect(text).to.be.equal("alanmulhall73");
                })
                .call(done);
        });
    });
});