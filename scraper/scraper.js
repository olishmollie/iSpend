const cheerioReq = require('cheerio-req')

function Scraper(app) {

  this.app = app

  this.sendRequest = (completionHandler) => {
    cheerioReq('http://news.ycombinator.com', (err, $) => {
      completionHandler($('body'))
    })
  }
}

module.exports = Scraper
